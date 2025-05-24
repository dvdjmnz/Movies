//
//  DataServicesAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class DataServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkService.self) { _ in
            return DefaultNetworkService()
        }.inObjectScope(.container)
    }
}
