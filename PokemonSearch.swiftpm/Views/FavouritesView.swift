//
//  SwiftUIView.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-08-08.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject private var favoriteService = FavoriteService.shared

    private var favourites: [UserDataModel.Favourite] { favoriteService.favourites }

    
    var body: some View {
        Group {
            if favourites.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "heart")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("No Favorites Yet")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("Add Pokemon to your favorites to see them here!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Grid of favorite Pokemon cards
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(favourites, id: \.name) { favorite in
                            NavigationLink(destination: PokemonView(name: favorite.name)) {
                                PokemonCardView(favorite: favorite)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
