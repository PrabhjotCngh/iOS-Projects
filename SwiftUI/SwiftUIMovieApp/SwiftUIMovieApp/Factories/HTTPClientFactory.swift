//
//  HTTPClientFactory.swift
//  UIKitMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation

class HTTPClientFactory {
    static func create() -> HTTPClient {
        let environment = ProcessInfo.processInfo.environment["Env"]
        if let environment, environment == "Test" {
            //return mock class
        }
        return HTTPClient()
    }
}
