//
//  MovieListModelTest.swift
//  TheMovieHubDBTests
//
//  Created by Atchibabu Chitri on 13/7/23.
//

import XCTest
import ComposableArchitecture

@testable import TheMovieHubDB

@MainActor
final class MovieListModelTest: XCTestCase {
    
    let cartItems: IdentifiedArrayOf<MovieModel> = IdentifiedArray(uniqueElements: moviesModel.sample.results ?? [])
    
    let store = TestStore(initialState: MovieListFeature.State(dataSource: IdentifiedArray(uniqueElements: moviesModel.sample.results ?? [])), reducer:MovieListFeature(allMovies: {_ in
        moviesModel.sample
    }))
    
    override func setUpWithError() throws {
    }
    
    func testAllMovies() async {
        let model = moviesModel.sample
        await store.send(.fetchMovieList)
        await store.receive(.movieList(.success(model)), timeout: 1)

    }
    
    func testMovieResponse() async {
        let model = moviesModel.sample
       await store.send(.movieList(.success(model)))
        await store.receive(.movieResponse(.success(model)), timeout: 1)
      
    }
    
    func testMovieResponseFail() async {
        let model = moviesModel.sample
        await store.send(.movieList(.failure(WebServiceError.invalidRequest)))
        await store.receive(.movieResponse(.failure(WebServiceError.invalidRequest)), timeout: 1)
    }
    
    func testloadMore() async {
        let model = moviesModel.sample
        await store.send(.loadMore(index: 0))
        await store.receive(.movieList(.success(model)), timeout: 1)

    }
    func testLastIndex() async {
        let model = moviesModel.sample.results?.first
        await store.send(.isLastIndex(model!)) {
            $0.isLoadMore = true
            $0.currentPage = 2
        }
    }
    
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
