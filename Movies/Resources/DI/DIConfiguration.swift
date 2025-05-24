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
    
    private var assembler: Assembler!
    private let container: Container
    
    private init() {
        container = Container()
        setup()
    }

    private func setup() {
        var assemblies = [Assembly]()
        // PRESENTATION
        // DOMAIN
        assemblies.append(contentsOf: DataAssembly().assemblies)
        // DATA
        assemblies.append(UseCasesAssembly())
        assembler = Assembler(assemblies, container: container)
    }
}
