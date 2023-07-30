//
//  File.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-27.
//

import Foundation

struct PokemonTypes: Codable {
    let results: [Result]
    
    struct Result: Codable {
        let name: String
        let url: String
    }
}

