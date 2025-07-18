//
//  PokemonBrowseView.swift
//  PokemonSearch
//
//  Created by Cascade on 2025-07-15.
//

import SwiftUI

struct PokemonBrowseView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.pokemon.isEmpty && viewModel.isLoading {
                    // Initial loading state
                    ProgressView("Loading Pokemon...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.hasError {
                    // Error state
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(.orange)
                        
                        Text("Oops! Something went wrong")
                            .font(.headline)
                        
                        Text(viewModel.errorMessage)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Try Again") {
                            Task {
                                await viewModel.refresh()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    // Pokemon list with infinite scroll
                    List {
                        ForEach(viewModel.pokemon) { pokemon in
                            NavigationLink(destination: PokemonView(name: pokemon.name)) {
                                PokemonListItemView(pokemon: pokemon)
                            }
                        }
                        
                        // Loading indicator at bottom for infinite scroll
                        if viewModel.nextURL != nil {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(0.8)
                                Spacer()
                            }
                            .onAppear {
                                Task {
                                    await viewModel.fetchMorePokemon()
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
    }
}



struct PokemonBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBrowseView()
    }
}
