//
//  TmdbEndpoint.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Foundation

enum TmdbEndpoint: Endpoint {
    case getMovieGenres
    case getTvShowsGenres
    case getMovies(genre: String, page: String)
    case getTvShows(genre: String, page: String)
    case getMovieDetails(movieId: String)
    case getTvShowDetails(tvShowId: String)
    
    private var endpoint: String {
        switch self {
        case .getMovieGenres:
            return "genre/movie/list"
        case .getTvShowsGenres:
            return "genre/tv/list"
        case .getMovies:
            return "discover/movie"
        case .getTvShows:
            return "discover/tv"
        case let .getMovieDetails(movieId):
            return "movie/\(movieId)"
        case let .getTvShowDetails(tvShowId):
            return "tv/\(tvShowId)"
        }
    }
    
    var builtUrl: URL {
        NetworkConstants.tmdbApiBaseUrl.appendingPathComponent(endpoint)
    }
    
    var method: HttpMethod {
        switch self {
        case .getMovieGenres:
            return .get
        case .getTvShowsGenres:
            return .get
        case .getMovies:
            return .get
        case .getTvShows:
            return .get
        case .getMovieDetails:
            return .get
        case .getTvShowDetails:
            return .get
        }
    }
    
    
    var headers: [String: String]? {
        switch self {
        case .getMovieGenres:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        case .getTvShowsGenres:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        case .getMovies:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        case .getTvShows:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        case .getMovieDetails:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        case .getTvShowDetails:
            return [
                NetworkConstants.Headers.accept: NetworkConstants.Headers.json,
                NetworkConstants.Headers.authorization: "Bearer " + NetworkConstants.tmdbApiKey
            ]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .getMovieGenres:
            return nil
        case .getTvShowsGenres:
            return nil
        case let .getMovies(genre, page):
            return [
                NetworkConstants.Params.genres: genre,
                NetworkConstants.Params.page: page
            ]
        case let .getTvShows(genre, page):
            return [
                NetworkConstants.Params.genres: genre,
                NetworkConstants.Params.page: page
            ]
        case .getMovieDetails:
            return nil
        case .getTvShowDetails:
            return nil
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .getMovieGenres:
            return nil
        case .getTvShowsGenres:
            return nil
        case .getMovies:
            return nil
        case .getTvShows:
            return nil
        case .getMovieDetails:
            return nil
        case .getTvShowDetails:
            return nil
        }
    }
}
