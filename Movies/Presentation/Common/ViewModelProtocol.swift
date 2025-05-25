//
//  ViewModelProtocol.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import RxSwift

protocol ViewModelInputProtocol {}

protocol ViewModelOutputProtocol {}

protocol ViewModelProtocol: AnyObject {    
    var disposeBag: DisposeBag { get }
    
    var input: ViewModelInputProtocol { get }
    var output: ViewModelOutputProtocol { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
}

extension ViewModelProtocol {
    func viewDidLoad() {}
    
    func viewWillAppear() {}
    
    func viewWillDisappear() {}

    func viewDidAppear() {}
}
