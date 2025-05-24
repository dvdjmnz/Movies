//
//  UseCasesAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetMovieDetailsUseCase.self) { resolver in
            let repository = resolver.resolve(MoviesRepository.self)!
            return DefaultGetMovieDetailsUseCase(repository: repository)
        }.inObjectScope(.graph)
        
        container.register(GetMovieGenresUseCase.self) { resolver in
            let repository = resolver.resolve(GenresRepository.self)!
            return DefaultGetMovieGenresUseCase(repository: repository)
        }.inObjectScope(.graph)
        
        container.register(GetMoviesUseCase.self) { resolver in
            let repository = resolver.resolve(MoviesRepository.self)!
            return DefaultGetMoviesUseCase(repository: repository)
        }.inObjectScope(.graph)
        
        container.register(GetTvShowDetailsUseCase.self) { resolver in
            let repository = resolver.resolve(TvShowsRepository.self)!
            return DefaultGetTvShowDetailsUseCase(repository: repository)
        }.inObjectScope(.graph)
        
        container.register(GetTvShowGenresUseCase.self) { resolver in
            let repository = resolver.resolve(GenresRepository.self)!
            return DefaultGetTvShowGenresUseCase(repository: repository)
        }.inObjectScope(.graph)
        
        container.register(GetTvShowsUseCase.self) { resolver in
            let repository = resolver.resolve(TvShowsRepository.self)!
            return DefaultGetTvShowsUseCase(repository: repository)
        }.inObjectScope(.graph)
    }
}

