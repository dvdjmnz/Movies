//
//  DIConfiguration.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//


import Swinject
import Foundation

class DIConfiguration {
    static let shared = DIConfiguration()
    
    let container: Container
    
    private var assembler: Assembler!
    
    private init() {
        container = Container()
        setup()
    }

    private func setup() {
        var assemblies = [Assembly]()
        // PRESENTATION
        assemblies.append(MovieListAssembly())
        // DOMAIN
        assemblies.append(contentsOf: DataAssembly().assemblies)
        // DATA
        assemblies.append(UseCasesAssembly())
        assembler = Assembler(assemblies, container: container)
    }
}
