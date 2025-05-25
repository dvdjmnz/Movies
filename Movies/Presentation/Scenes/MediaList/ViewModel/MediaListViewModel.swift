//
//  MediaListViewModel.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation
import RxSwift

protocol MediaListViewModelInputProtocol: ViewModelInputProtocol {
    associatedtype Item: MediaItem
    
    var genreSelected: AnyObserver<Genre> { get }
    var refreshTrigger: AnyObserver<Void> { get }
    var fetchItemDetails: AnyObserver<Item> { get }
    var loadNextPageTrigger: AnyObserver<Void> { get }
}

protocol MediaListViewModelOutputProtocol: ViewModelOutputProtocol {
    associatedtype Item: MediaItem
    associatedtype Details: MediaItemDetails
    
    var genresDataSource: Observable<[Genre]> { get }
    var itemsWithDetailsDataSource: Observable<[MediaItemWithDetails<Item, Details>]> { get }
    var isLoading: Observable<Bool> { get }
}

// MARK: - Concrete Input Protocol
protocol MediaListViewModelInputConcreteProtocol<Item>: MediaListViewModelInputProtocol where Item: MediaItem {}

// MARK: - Concrete Output Protocol
protocol MediaListViewModelOutputConcreteProtocol<Item, Details>: MediaListViewModelOutputProtocol where Item: MediaItem, Details: MediaItemDetails {}

// MARK: - Generic Input/Output Structs
struct MediaListViewModelInput<Item: MediaItem>: MediaListViewModelInputConcreteProtocol {
    var genreSelected: AnyObserver<Genre>
    var refreshTrigger: AnyObserver<Void>
    var fetchItemDetails: AnyObserver<Item>
    var loadNextPageTrigger: AnyObserver<Void>
}

struct MediaListViewModelOutput<Item: MediaItem, Details: MediaItemDetails>: MediaListViewModelOutputConcreteProtocol {
    var genresDataSource: Observable<[Genre]>
    var itemsWithDetailsDataSource: Observable<[MediaItemWithDetails<Item, Details>]>
    var isLoading: Observable<Bool>
}

// MARK: - Generic ViewModel
class MediaListViewModel<Item: MediaItem, Details: MediaItemDetails>: ViewModelProtocol {
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Input and output
    var input: ViewModelInputProtocol
    var output: ViewModelOutputProtocol
    
    // MARK: Subjects
    private let genreSelectedSubject = PublishSubject<Genre>()
    private let refreshTriggerSubject = PublishSubject<Void>()
    private let fetchItemDetailsSubject = PublishSubject<Item>()
    private let loadNextPageTriggerSubject = PublishSubject<Void>()
    private let genresDataSourceSubject = BehaviorSubject<[Genre]>(value: [])
    private let itemsWithDetailsDataSourceSubject = BehaviorSubject<[MediaItemWithDetails<Item, Details>]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    
    // MARK: Caching and state
    private var cachedItemDetails: [Int: Details] = [:]
    private var pendingDetailRequests: Set<Int> = []
    private var allItems: [Item] = []
    
    // MARK: Pagination state
    private var currentGenreId: Int?
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    private var isLoadingNextPage: Bool = false
    
    // MARK: Use cases
    private let getGenresUseCase: () -> Observable<[Genre]>
    private let getItemsUseCase: (Int, Int) -> Observable<Page<Item>>
    private let getItemDetailsUseCase: (Int) -> Observable<Details>
    
    // MARK: Init
    init(getGenresUseCase: @escaping () -> Observable<[Genre]>,
         getItemsUseCase: @escaping (Int, Int) -> Observable<Page<Item>>,
         getItemDetailsUseCase: @escaping (Int) -> Observable<Details>) {
        self.getGenresUseCase = getGenresUseCase
        self.getItemsUseCase = getItemsUseCase
        self.getItemDetailsUseCase = getItemDetailsUseCase
        
        input = MediaListViewModelInput<Item>(
            genreSelected: genreSelectedSubject.asObserver(),
            refreshTrigger: refreshTriggerSubject.asObserver(),
            fetchItemDetails: fetchItemDetailsSubject.asObserver(),
            loadNextPageTrigger: loadNextPageTriggerSubject.asObserver()
        )
        
        output = MediaListViewModelOutput<Item, Details>(
            genresDataSource: genresDataSourceSubject.asObservable().observe(on: MainScheduler.instance),
            itemsWithDetailsDataSource: itemsWithDetailsDataSourceSubject.asObservable().observe(on: MainScheduler.instance),
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
                self.updateItemsWithDetailsDataSource()
                self.fetchItems(genreId: genre.id, page: 1, isRefresh: true)
            })
            .disposed(by: disposeBag)
        
        refreshTriggerSubject
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.refreshCurrentData()
            })
            .disposed(by: disposeBag)
        
        fetchItemDetailsSubject
            .filter { [weak self] item in
                guard let self = self else { return false }
                return self.cachedItemDetails[item.id] == nil && !self.pendingDetailRequests.contains(item.id)
            }
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.fetchItemDetails(itemId: item.id)
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
        allItems = []
    }
    
    private func refreshCurrentData() {
        if let genreId = currentGenreId {
            resetPaginationState()
            fetchItems(genreId: genreId, page: 1, isRefresh: true)
        } else {
            fetchGenres()
        }
    }
    
    private func loadNextPage(genreId: Int) {
        guard !isLoadingNextPage && currentPage < totalPages else { return }
        let nextPage = currentPage + 1
        fetchItems(genreId: genreId, page: nextPage, isRefresh: false)
    }
    
    private func updateItemsWithDetailsDataSource() {
        let itemsWithDetails = allItems.map { item in
            MediaItemWithDetails<Item, Details>(
                item: item,
                details: cachedItemDetails[item.id]
            )
        }
        itemsWithDetailsDataSourceSubject.onNext(itemsWithDetails)
    }
}

extension MediaListViewModel {
    private func fetchGenres() {
        isLoadingSubject.onNext(true)
        
        getGenresUseCase()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] genres in
                    guard let self = self else { return }
                    self.genresDataSourceSubject.onNext(genres)
                    
                    if let firstGenre = genres.first {
                        self.resetPaginationState()
                        self.currentGenreId = firstGenre.id
                        self.fetchItems(genreId: firstGenre.id, page: 1, isRefresh: true)
                    }
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.isLoadingSubject.onNext(false)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func fetchItems(genreId: Int, page: Int, isRefresh: Bool) {
        if isLoadingNextPage && !isRefresh { return }
        isLoadingNextPage = true
        isLoadingSubject.onNext(true)
        
        getItemsUseCase(genreId, page)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] itemsPage in
                    guard let self = self else { return }
                    self.currentPage = itemsPage.page
                    self.totalPages = itemsPage.totalPages
                    
                    if isRefresh {
                        self.allItems = itemsPage.results
                    } else {
                        self.allItems.append(contentsOf: itemsPage.results)
                    }
                    
                    self.updateItemsWithDetailsDataSource()
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
    
    private func fetchItemDetails(itemId: Int) {
        pendingDetailRequests.insert(itemId)
        
        getItemDetailsUseCase(itemId)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] itemDetails in
                    guard let self = self else { return }
                    self.cachedItemDetails[itemDetails.id] = itemDetails
                    self.pendingDetailRequests.remove(itemId)
                    self.updateItemsWithDetailsDataSource()
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    self.pendingDetailRequests.remove(itemId)
                }
            )
            .disposed(by: disposeBag)
    }
}
