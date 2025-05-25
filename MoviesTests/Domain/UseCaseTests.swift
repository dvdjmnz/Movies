//
//  UseCaseTests.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 25/5/25.
//

import XCTest
import RxSwift
import RxBlocking
@testable import Movies

// MARK: - Use Case Tests
class UseCaseTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    // MARK: - Genres Tests
    func testGetMovieGenres_Success() {
        let mockRepository = MockGenresRepository()
        let useCase = DefaultGetMovieGenresUseCase(repository: mockRepository)
        
        let result = try! useCase.execute().toBlocking().first()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?.first?.name, "Action")
    }
    
    func testGetMovieGenres_Error() {
        let mockRepository = MockGenresRepository()
        mockRepository.shouldReturnError = true
        let useCase = DefaultGetMovieGenresUseCase(repository: mockRepository)
        
        XCTAssertThrowsError(try useCase.execute().toBlocking().first())
    }
    
    // MARK: - Movies Tests
    func testGetMovies_Success() {
        let mockRepository = MockMoviesRepository()
        let useCase = DefaultGetMoviesUseCase(repository: mockRepository)
        
        let result = try! useCase.execute(genre: 1, page: 1).toBlocking().first()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.page, 1)
        XCTAssertEqual(result?.results.count, 2)
        XCTAssertEqual(result?.results.first?.title, "Test Movie 1")
        XCTAssertTrue(result?.hasNextPage == true)
    }
    
    func testGetMovies_Error() {
        let mockRepository = MockMoviesRepository()
        mockRepository.shouldReturnError = true
        let useCase = DefaultGetMoviesUseCase(repository: mockRepository)
        
        XCTAssertThrowsError(try useCase.execute(genre: 1, page: 1).toBlocking().first())
    }
    
    // MARK: - Movie Details Tests
    func testGetMovieDetails_Success() {
        let mockRepository = MockMoviesRepository()
        let useCase = DefaultGetMovieDetailsUseCase(repository: mockRepository)
        
        let result = try! useCase.execute(movieId: 1).toBlocking().first()

        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, 1)
        XCTAssertEqual(result?.revenue, "$100M")
        XCTAssertEqual(result?.budget, "$50M")
    }
    
    func testGetMovieDetails_Error() {
        let mockRepository = MockMoviesRepository()
        mockRepository.shouldReturnError = true
        let useCase = DefaultGetMovieDetailsUseCase(repository: mockRepository)
        
        XCTAssertThrowsError(try useCase.execute(movieId: 1).toBlocking().first())
    }
}
