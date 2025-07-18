//
//  PokemonListItemView.swift
//  PokemonSearch
//
//  Created by Cascade on 2025-07-15.
//

import SwiftUI

struct PokemonListItemView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            // Pokemon artwork
            AsyncImage(url: URL(string: pokemon.artworkURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                            .scaleEffect(0.6)
                    }
            }
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                
                Text("# \(pokemon.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct PokemonListItemView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Pokemon for preview
        let samplePokemon = Pokemon(
            name: "pikachu",
            url: "https://pokeapi.co/api/v2/pokemon/25/"
        )
        
        PokemonListItemView(pokemon: samplePokemon)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
