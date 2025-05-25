//
//  DataSourcesAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class DataSourcesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TmdbDataSource.self) { _ in
            return DefaultTmdbDataSource(networkService: DefaultNetworkService())
        }.inObjectScope(.container)
    }
}
