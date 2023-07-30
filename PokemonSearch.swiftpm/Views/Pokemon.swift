//
//  SwiftUIView.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-29.
//

import SwiftUI

struct Pokemon: View {
    var name: String
    
    @State private var pokemon: PokemonDetails?
    
    let pokeService = PokemonService()
    
    var body: some View {
        ScrollView {
            Text(pokemon?.name.uppercased() ?? "")
            AsyncImage(url: URL(string: pokemon?.sprites.other.home.frontDefault ?? ""), scale: 2)
        }
        .task{
            do {
                self.pokemon = try await pokeService.getPokemon(for: name)
            } catch {
                print("Not able to fetch")
            }
        }
    }
}

