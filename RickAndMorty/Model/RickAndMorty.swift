//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Character]
    let info: Info
}

struct Character: Decodable {
    let name: String
    var image: String
    let species: String
    let gender: String
    let status: String
    let location: Location
    let episode: [String]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
}

struct Location: Decodable {
    let name: String
}
