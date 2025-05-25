//
//  MovieListAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class MovieListAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieListViewModel.self) { resolver in
            let getMovieGenresUseCase = resolver.resolve(GetMovieGenresUseCase.self)!
            let getMoviesUseCase = resolver.resolve(GetMoviesUseCase.self)!
            let getMovieDetailsUseCase = resolver.resolve(GetMovieDetailsUseCase.self)!
            return MovieListViewModel(
                getMovieGenresUseCase: getMovieGenresUseCase,
                getMoviesUseCase: getMoviesUseCase,
                getMovieDetailsUseCase: getMovieDetailsUseCase
            )
        }.inObjectScope(.transient)
        
        container.register(MovieListViewController.self) { resolver in
            let viewController = MovieListViewController()
            let viewModel = resolver.resolve(MovieListViewModel.self)!
            viewController.viewModel = viewModel
            return viewController
        }.inObjectScope(.transient)
    }
}

