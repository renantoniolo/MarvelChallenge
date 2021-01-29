//
//  MarvelClass.swift
//  marvelChallenge
//
//  Created by Renan Rocha on 27/01/21.
//

import Foundation

struct MarvelInfo : Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

struct Hero : Codable {
    let id: Int
    let name: String
    let description: String
    var verifiedDescription: String {
        if(!description.isEmpty){ return description }
        else{ return "there is no description for this character."}
    }
    let thumbnail: Thumbnail
    let urls: [HeroURL]
}

struct Thumbnail : Codable {
    let path : String
    var url: String {
        return "\(path.replacingOccurrences(of: "http", with: "https")).jpg"
    }
}

struct HeroURL : Codable {
    let type: String
    let url: String
    var urlHttps: String {
        return "\(url.replacingOccurrences(of: "http", with: "https"))"
    }
}
