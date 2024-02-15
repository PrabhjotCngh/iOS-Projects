//
//  MockHttpClient.swift
//  SwiftUIMovieAppTests
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation
import Combine

class MockHttpClient: HTTPClientService {
    func fetchMovies(searchString: String) -> AnyPublisher<[Movie], Error> {
       let movies = [Movie(title: "test", year: "test", imdbId: "test", poster: URL(string: "test"))]
       return Just(movies).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
