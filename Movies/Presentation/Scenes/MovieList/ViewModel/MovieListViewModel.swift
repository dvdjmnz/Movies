//
//  MovieListViewModel.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation
import RxSwift

protocol MovieListViewModelInputProtocol: ViewModelInputProtocol {
    var genreSelected: AnyObserver<Genre> { get }
    var refreshTrigger: AnyObserver<Void> { get }
    var fetchMovieDetails: AnyObserver<Movie> { get }
    var loadNextPageTrigger: AnyObserver<Void> { get }
}

struct MovieListViewModelInput: MovieListViewModelInputProtocol {
    var genreSelected: AnyObserver<Genre>
    var refreshTrigger: AnyObserver<Void>
    var fetchMovieDetails: AnyObserver<Movie>
    var loadNextPageTrigger: AnyObserver<Void>
}

protocol MovieListViewModelOutputProtocol: ViewModelOutputProtocol {
    var genresDataSource: Observable<[Genre]> { get }
    var moviesWithDetailsDataSource: Observable<[MovieWithDetails]> { get }
    var isLoading: Observable<Bool> { get }
}

struct MovieListViewModelOutput: MovieListViewModelOutputProtocol {
    var genresDataSource: Observable<[Genre]>
    var moviesWithDetailsDataSource: Observable<[MovieWithDetails]>
    var isLoading: Observable<Bool>
}

class MovieListViewModel: ViewModelProtocol {
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Input and output
    var input: ViewModelInputProtocol
    var output: ViewModelOutputProtocol
    
    // MARK: Subjects
    private let genreSelectedSubject = PublishSubject<Genre>()
    private let refreshTriggerSubject = PublishSubject<Void>()
    private let fetchMovieDetailsSubject = PublishSubject<Movie>()
    private let loadNextPageTriggerSubject = PublishSubject<Void>()
    private let genresDataSourceSubject = BehaviorSubject<[Genre]>(value: [])
    private let moviesWithDetailsDataSourceSubject = BehaviorSubject<[MovieWithDetails]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    
    // MARK: Caching and state
    private var cachedMovieDetails: [Int: MovieDetails] = [:]
    private var pendingDetailRequests: Set<Int> = []
    private var allMovies: [Movie] = []
    
    // MARK: Pagination state
    private var currentGenreId: Int?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var isLoadingNextPage: Bool = false
    
    // MARK: Use cases
    private let getMovieGenresUseCase: GetMovieGenresUseCase
    private let getMoviesUseCase: GetMoviesUseCase
    private let getMovieDetailsUseCase: GetMovieDetailsUseCase
    
    
    // MARK: Init
    init(getMovieGenresUseCase: GetMovieGenresUseCase,
         getMoviesUseCase: GetMoviesUseCase,
         getMovieDetailsUseCase: GetMovieDetailsUseCase) {
        self.getMovieGenresUseCase = getMovieGenresUseCase
        self.getMoviesUseCase = getMoviesUseCase
        self.getMovieDetailsUseCase = getMovieDetailsUseCase
        
        input = MovieListViewModelInput(
            genreSelected: genreSelectedSubject.asObserver(),
            refreshTrigger: refreshTriggerSubject.asObserver(),
            fetchMovieDetails: fetchMovieDetailsSubject.asObserver(),
            loadNextPageTrigger: loadNextPageTriggerSubject.asObserver()
        )
        
        output = MovieListViewModelOutput(
            genresDataSource: genresDataSourceSubject.asObservable().observe(on: MainScheduler.instance),
            moviesWithDetailsDataSource: moviesWithDetailsDataSourceSubject.asObservable().observe(on: MainScheduler.instance),
            isLoading: isLoadingSubject.asObservable().observe(on: MainScheduler.instance)
        )
        
        setupRx()
    }
    
    func viewDidLoad() {
        fetchGenres()
    }
    
    func setupRx() {
        genreSelectedSubject
            .subscribe(onNext: { [weak self] genre in
                guard let self = self else { return }
                self.resetPaginationState()
                self.currentGenreId = genre.id
                self.updateMoviesWithDetailsDataSource()
                self.fetchMovies(genreId: genre.id, page: 1, isRefresh: true)
            })
            .disposed(by: disposeBag)
        
        refreshTriggerSubject
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.refreshCurrentData()
            })
            .disposed(by: disposeBag)
        
        fetchMovieDetailsSubject
            .filter { [weak self] movie in
                guard let self = self else { return false }
                return self.cachedMovieDetails[movie.id] == nil && !self.pendingDetailRequests.contains(movie.id)
            }
            .subscribe(onNext: { [weak self] movie in
                guard let self = self else { return }
                self.fetchMovieDetails(movieId: movie.id)
            })
            .disposed(by: disposeBag)
        
        loadNextPageTriggerSubject
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return !self.isLoadingNextPage && self.currentPage < self.totalPages
            }
            .subscribe(onNext: { [weak self] in
                guard let self = self, let genreId = self.currentGenreId else { return }
                self.loadNextPage(genreId: genreId)
            })
            .disposed(by: disposeBag)
    }
    
    private func resetPaginationState() {
        currentPage = 1
        totalPages = 1
        isLoadingNextPage = false
        allMovies = []
    }
    
    private func refreshCurrentData() {
        if let genreId = currentGenreId {
            resetPaginationState()
            fetchMovies(genreId: genreId, page: 1, isRefresh: true)
        } else {
            fetchGenres()
        }
    }
    
    private func loadNextPage(genreId: Int) {
        guard !isLoadingNextPage && currentPage < totalPages else { return }
        let nextPage = currentPage + 1
        fetchMovies(genreId: genreId, page: nextPage, isRefresh: false)
    }
    
    private func updateMoviesWithDetailsDataSource() {
        let moviesWithDetails = allMovies.map { movie in
            MovieWithDetails(
                movie: movie,
                details: cachedMovieDetails[movie.id]
            )
        }
        moviesWithDetailsDataSourceSubject.onNext(moviesWithDetails)
    }
}

extension MovieListViewModel {
    private func fetchGenres() {
        isLoadingSubject.onNext(true)
        
        getMovieGenresUseCase.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] genres in
                    guard let self = self else { return }
                    self.genresDataSourceSubject.onNext(genres)
                    
                    if let firstGenre = genres.first {
                        self.resetPaginationState()
                        self.currentGenreId = firstGenre.id
                        self.fetchMovies(genreId: firstGenre.id, page: 1, isRefresh: true)
                    }
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.isLoadingSubject.onNext(false)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func fetchMovies(genreId: Int, page: Int, isRefresh: Bool) {
        if isLoadingNextPage && !isRefresh { return }
        isLoadingNextPage = true
        isLoadingSubject.onNext(true)
        
        getMoviesUseCase.execute(genre: genreId, page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] moviesPage in
                    guard let self = self else { return }
                    self.currentPage = moviesPage.page
                    self.totalPages = moviesPage.totalPages
                    
                    if isRefresh {
                        self.allMovies = moviesPage.results
                    } else {
                        self.allMovies.append(contentsOf: moviesPage.results)
                    }
                    
                    self.updateMoviesWithDetailsDataSource()
                    self.isLoadingSubject.onNext(false)
                    self.isLoadingNextPage = false
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.isLoadingSubject.onNext(false)
                    self.isLoadingNextPage = false
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func fetchMovieDetails(movieId: Int) {
        pendingDetailRequests.insert(movieId)
        
        getMovieDetailsUseCase.execute(movieId: movieId)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] movieDetails in
                    guard let self = self else { return }
                    self.cachedMovieDetails[movieDetails.id] = movieDetails
                    self.pendingDetailRequests.remove(movieId)
                    self.updateMoviesWithDetailsDataSource()
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.pendingDetailRequests.remove(movieId)
                }
            )
            .disposed(by: disposeBag)
    }
}
