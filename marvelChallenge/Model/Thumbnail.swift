//
//  Thumbnail.swift
//  marvelChallenge
//
//  Created by Renan Toniolo Rocha on 03/02/21.
//

import Foundation

struct Thumbnail : Codable {
    let path : String
    var url: String {
        return "\(path.replacingOccurrences(of: "http", with: "https")).jpg"
    }
}
