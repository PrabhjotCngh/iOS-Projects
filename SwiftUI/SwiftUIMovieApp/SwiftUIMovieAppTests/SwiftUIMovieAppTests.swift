//
//  SwiftUIMovieAppTests.swift
//  SwiftUIMovieAppTests
//
//  Created by M_2195552 on 2024-02-11.
//

import XCTest
import Combine

final class SwiftUIMovieAppTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchEnvironment = ["Env": "Test"]
        continueAfterFailure = true
        app.launch()
    }
    
    func testFetchMovies() throws {
       
        let httpClient = HTTPClient()
        let expection = XCTestExpectation(description: "Received movies")
        
        httpClient.fetchMovies(searchString: "Batman")
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        XCTFail("Request failed with error \(error)")
                }
            } receiveValue: { movies in
                XCTAssertTrue(movies.count > 0)
                expection.fulfill()
            }.store(in: &cancellables)

        wait(for: [expection], timeout: 5.0)
        
    }

}
