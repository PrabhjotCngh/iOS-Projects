//
//  Movie.swift
//  UIKitMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation

struct MovieResponse: Decodable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Identifiable, Decodable {
    let title: String
    let year: String
    let imdbId: String
    let poster: URL?
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}
