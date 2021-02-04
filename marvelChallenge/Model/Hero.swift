//
//  Hero.swift
//  marvelChallenge
//
//  Created by Renan Toniolo Rocha on 03/02/21.
//

import Foundation

struct Hero : Codable {
    let id: Int
    let name: String
    let description: String
    var verifiedDescription: String {
        if(!description.isEmpty){ return description }
        else{ return "there is no description for this character."}
    }
    let thumbnail: Thumbnail
}
