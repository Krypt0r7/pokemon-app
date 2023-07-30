//
//  File.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-28.
//

import Foundation

struct PokemonType: Codable {
    struct Pokemon: Codable {
        let name: String
        let url: String
    }
    
    struct PokemonResult: Codable {
        let pokemon: Pokemon
    }
    
    let pokemon: [PokemonResult]
}
