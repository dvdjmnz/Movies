//
//  ViewModelTests.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Movies

// MARK: - ViewModel Tests
class ViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func testViewModel_GenreSelection() {
        let viewModel = MediaListViewModel<Movie, MovieDetails>(
            getGenresUseCase: { Observable.just([TestData.genre]) },
            getItemsUseCase: { _, _ in 
                Observable.just(Page(page: 1, totalPages: 1, results: [TestData.movie]))
            },
            getItemDetailsUseCase: { _ in Observable.just(TestData.movieDetails) }
        )
        let input = viewModel.input as! MediaListViewModelInput<Movie>
        let output = viewModel.output as! MediaListViewModelOutput<Movie, MovieDetails>
        viewModel.viewDidLoad()
        
        input.genreSelected.onNext(TestData.genre)
        
        let items = try! output.itemsWithDetailsDataSource.skip(2).take(1).toBlocking().first()
        XCTAssertNotNil(items)
        XCTAssertEqual(items?.count, 1)
    }
}
