//
//  TmdbDataSource.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol TmdbDataSource {
    func getMovieGenres() -> Observable<[GenreDTO]>
    func getTvShowsGenres() -> Observable<[GenreDTO]>
    func getMovies(genre: Int) -> Observable<PageDto<MovieDTO>>
    func getTvShows(genre: Int) -> Observable<PageDto<TvShowDTO>>
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsDTO>
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetailsDTO>
}

struct DefaultTmdbDataSource {
    let networkService: NetworkService
    
    func getMovieGenres() -> Observable<[GenreDTO]> {
        let endpoint = TmdbEndpoint.getMovieGenres
        let request = APIRequest<GenresResponseDTO>(endpoint: endpoint)
        return networkService.execute(request).map(\.genres)
    }
    
    func getTvShowsGenres() -> Observable<[GenreDTO]> {
        let endpoint = TmdbEndpoint.getTvShowsGenres
        let request = APIRequest<GenresResponseDTO>(endpoint: endpoint)
        return networkService.execute(request).map(\.genres)
    }
    
    func getMovies(genre: Int) -> Observable<PageDto<MovieDTO>> {
        let endpoint = TmdbEndpoint.getMovies(genre: String(genre))
        let request = APIRequest<PageDto<MovieDTO>>(endpoint: endpoint)
        return networkService.execute(request)
    }
    
    func getTvShows(genre: Int) -> Observable<PageDto<TvShowDTO>> {
        let endpoint = TmdbEndpoint.getTvShows(genre: String(genre))
        let request = APIRequest<PageDto<TvShowDTO>>(endpoint: endpoint)
        return networkService.execute(request)
    }
    
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsDTO> {
        let endpoint = TmdbEndpoint.getMovieDetails(movieId: String(movieId))
        let request = APIRequest<MovieDetailsDTO>(endpoint: endpoint)
        return networkService.execute(request)
    }
    
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetailsDTO> {
        let endpoint = TmdbEndpoint.getTvShowDetails(tvShowId: String(tvShowId))
        let request = APIRequest<TvShowDetailsDTO>(endpoint: endpoint)
        return networkService.execute(request)
    }
}
