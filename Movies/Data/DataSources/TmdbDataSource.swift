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
    func getMovies(genre: Int, page: Int) -> Observable<PageDTO<MovieDTO>>
    func getTvShows(genre: Int, page: Int) -> Observable<PageDTO<TvShowDTO>>
    func getMovieDetails(movieId: Int) -> Observable<MovieDetailsDTO>
    func getTvShowDetails(tvShowId: Int) -> Observable<TvShowDetailsDTO>
}

class DefaultTmdbDataSource {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultTmdbDataSource: TmdbDataSource {
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
    
    func getMovies(genre: Int, page: Int) -> Observable<PageDTO<MovieDTO>> {
        let endpoint = TmdbEndpoint.getMovies(genre: String(genre), page: String(page))
        let request = APIRequest<PageDTO<MovieDTO>>(endpoint: endpoint)
        return networkService.execute(request)
    }
    
    func getTvShows(genre: Int, page: Int) -> Observable<PageDTO<TvShowDTO>> {
        let endpoint = TmdbEndpoint.getTvShows(genre: String(genre), page: String(page))
        let request = APIRequest<PageDTO<TvShowDTO>>(endpoint: endpoint)
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
