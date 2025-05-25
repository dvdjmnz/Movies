//
//  MediaListAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class MediaListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MediaListViewModel<Movie, MovieDetails>.self) { resolver in
            let getMovieGenresUseCase = resolver.resolve(GetMovieGenresUseCase.self)!
            let getMoviesUseCase = resolver.resolve(GetMoviesUseCase.self)!
            let getMovieDetailsUseCase = resolver.resolve(GetMovieDetailsUseCase.self)!
            return MediaListViewModel<Movie, MovieDetails>(
                getGenresUseCase: { getMovieGenresUseCase.execute() },
                getItemsUseCase: { genre, page in getMoviesUseCase.execute(genre: genre, page: page) },
                getItemDetailsUseCase: { itemId in getMovieDetailsUseCase.execute(movieId: itemId) }
            )
        }.inObjectScope(.transient)
        
        container.register(MediaListViewModel<TvShow, TvShowDetails>.self) { resolver in
            let getTvShowGenresUseCase = resolver.resolve(GetTvShowGenresUseCase.self)!
            let getTvShowsUseCase = resolver.resolve(GetTvShowsUseCase.self)!
            let getTvShowDetailsUseCase = resolver.resolve(GetTvShowDetailsUseCase.self)!
            return MediaListViewModel<TvShow, TvShowDetails>(
                getGenresUseCase: { getTvShowGenresUseCase.execute() },
                getItemsUseCase: { genre, page in getTvShowsUseCase.execute(genre: genre, page: page) },
                getItemDetailsUseCase: { itemId in getTvShowDetailsUseCase.execute(tvShowId: itemId) }
            )
        }.inObjectScope(.transient)
        
        container.register(MovieListViewController.self) { resolver in
            let viewController = MovieListViewController()
            let viewModel = resolver.resolve(MediaListViewModel<Movie, MovieDetails>.self)!
            viewController.viewModel = viewModel
            return viewController
        }.inObjectScope(.transient)
        
        container.register(TvShowListViewController.self) { resolver in
            let viewController = TvShowListViewController()
            let viewModel = resolver.resolve(MediaListViewModel<TvShow, TvShowDetails>.self)!
            viewController.viewModel = viewModel
            return viewController
        }.inObjectScope(.transient)
    }
}

