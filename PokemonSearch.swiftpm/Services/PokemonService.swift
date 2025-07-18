//
//  File.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-21.
//

import Foundation

struct PokemonService {
    func getPokemon(for name: String) async throws -> PokemonDetails {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"

        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemon: PokemonDetails = try decode(data)
        print(pokemon)
        return pokemon
        
    }
    
    func getTypes() async throws -> PokemonTypes {
        let urlString = "https://pokeapi.co/api/v2/type"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result: PokemonTypes = try decode(data)
        return result
    }
    
    func getPokemonsByType(url: String) async throws -> PokemonType {
        guard let pokeUrl = URL(string: url) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: pokeUrl)
        
        let pokeType: PokemonType = try decode(data)
        return pokeType
    }
    
    // MARK: - Generic Fetch Function for Pagination
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decode(data)
    }
    
    // MARK: - Paginated Pokemon List Function
    func fetchPokemon(from url: URL) async throws -> PokemonListResponse {
        return try await fetch(from: url)
    }
    
    // Convenience method to fetch the first page
    func fetchPokemonList(limit: Int = 20, offset: Int = 0) async throws -> PokemonListResponse {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        return try await fetchPokemon(from: url)
    }
    
    func decode<T: Decodable>(_ data: Data ) throws -> T {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}

