//
//  HTTPClient.swift
//  UIKitMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

protocol HTTPClientService {
    func fetchMovies(searchString: String) -> AnyPublisher<[Movie], Error>
}

class HTTPClient: HTTPClientService {
    
    func fetchMovies(searchString: String) -> AnyPublisher<[Movie], Error> {
        
        guard let encodedString = searchString.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedString)&page=2&apikey=564727fa")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
}
