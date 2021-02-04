//
//  MarvelData.swift
//  marvelChallenge
//
//  Created by Renan Toniolo Rocha on 03/02/21.
//

import Foundation

struct MarvelData : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}
