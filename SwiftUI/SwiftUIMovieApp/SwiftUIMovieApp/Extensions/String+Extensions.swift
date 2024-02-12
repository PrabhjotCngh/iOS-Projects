//
//  String+Extensions.swift
//  UIKitMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation

extension String {
    
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
