//
//  TestMocks.swift
//  MoviesTests
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import RxSwift
@testable import Movies

// MARK: - Mock Repositories
class MockGenresRepository: GenresRepository {
    var shouldReturnError = false
    
    func getMovieGenres() -> Observable<[Genre]> {
        if shouldReturnError {
            return Observable.error(NetworkError.serverError)
        }
        return Observable.just([
            Genre(id: 1, name: "Action"),
            Genre(id: 2, name: "Comedy")
        ])
    }
    
    func getTvShowsGenres() -> Observable<[Genre]> {
        if shouldReturnError {
            return Observable.error(NetworkError.serverError)
        }
        return Observable.just([
            Genre(id: 1, name: "Drama"),
            Genre(id: 2, name: "Thriller")
        ])
    }
}

class MockMoviesRepository: MoviesRepository {
    var shouldReturnError = false
    
    func getMovies(genre: Int, page: Int) -> Observable<Page<Movie>> {
        if shouldReturnError {
            return Observable.error(NetworkError.noInternet)
        }
        let movies = [
            Movie(id: 1, title: "Test Movie 1", voteAverage: "7.5", posterPath: nil),
            Movie(id: 2, title: "Test Movie 2", voteAverage: "8.0", posterPath: nil)
        ]
        return Observable.just(Page(page: page, totalPages: 2, results: movies))
    }
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetails> {
        if shouldReturnError {
            return Observable.error(NetworkError.notFound)
        }
        return Observable.just(MovieDetails(id: movieId, revenue: "$100M", budget: "$50M"))
    }
}

// MARK: - Test Data
class TestData {
    static let genre = Genre(id: 1, name: "Action")
    static let movie = Movie(id: 1, title: "Test Movie", voteAverage: "7.5", posterPath: nil)
    static let movieDetails = MovieDetails(id: 1, revenue: "$100M", budget: "$50M")
}
