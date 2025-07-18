//
//  PokemonCardView.swift
//  PokemonSearch
//
//  Created by Cascade on 2025-07-15.
//

import SwiftUI

struct PokemonCardView: View {
    let favorite: UserDataModel.Favourite
    
    var body: some View {
        VStack(spacing: 12) {
            // Pokemon artwork
            AsyncImage(url: favorite.image.isEmpty ? nil : URL(string: favorite.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    // Error state - show Pokemon icon
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        }
                case .empty:
                    // Loading state
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            ProgressView()
                                .scaleEffect(0.8)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 120, height: 120)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // Pokemon name
            Text(favorite.name.capitalized)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFavorite = UserDataModel.Favourite(
            "pikachu",
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
        )
        
        PokemonCardView(favorite: sampleFavorite)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemGroupedBackground))
    }
}
