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
