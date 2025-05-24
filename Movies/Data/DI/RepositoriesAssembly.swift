//
//  RepositoriesAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GenresRepository.self) { resolver in
            let tmdbDataSource = resolver.resolve(TmdbDataSource.self)!
            return DefaultGenresRepository(tmdbDataSource: tmdbDataSource)
        }.inObjectScope(.container)
        
        container.register(MoviesRepository.self) { resolver in
            let tmdbDataSource = resolver.resolve(TmdbDataSource.self)!
            return DefaultMoviesRepository(tmdbDataSource: tmdbDataSource)
        }.inObjectScope(.container)
        
        container.register(TvShowsRepository.self) { resolver in
            let tmdbDataSource = resolver.resolve(TmdbDataSource.self)!
            return DefaultTvShowsRepository(tmdbDataSource: tmdbDataSource)
        }.inObjectScope(.container)
    }
}
