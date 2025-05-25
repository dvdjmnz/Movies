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
        Constants.Network.tmdbApiBaseUrl.appendingPathComponent(endpoint)
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
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
            ]
        case .getTvShowsGenres:
            return [
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
            ]
        case .getMovies:
            return [
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
            ]
        case .getTvShows:
            return [
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
            ]
        case .getMovieDetails:
            return [
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
            ]
        case .getTvShowDetails:
            return [
                Constants.Network.Headers.accept: Constants.Network.Headers.json,
                Constants.Network.Headers.authorization: "Bearer " + Constants.Network.tmdbApiKey
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
                Constants.Network.Params.genres: genre,
                Constants.Network.Params.page: page
            ]
        case let .getTvShows(genre, page):
            return [
                Constants.Network.Params.genres: genre,
                Constants.Network.Params.page: page
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
