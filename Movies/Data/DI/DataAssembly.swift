//
//  DataAssembly.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import Swinject

class DataAssembly {
    var assemblies: [Assembly] {
        [
            DataSourcesAssembly(),
            RepositoriesAssembly(),
            DataServicesAssembly()
        ]
    }
}

