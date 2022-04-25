//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Валентина Лучинович on 25.04.2022.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Character]
    let info: Pages
}

struct Character: Decodable {
    let name: String
    let image: String
    let species: String
    let gender: String
    let status: String
}

struct Pages: Decodable {
    let pages: Int
    let next: String?
}
