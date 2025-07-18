//
//  PokemonListViewModel.swift
//  PokemonSearch
//
//  Created by Cascade on 2025-07-15.
//

import Foundation
import SwiftUI

@MainActor
class PokemonListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var pokemon: [Pokemon] = []
    @Published var nextURL: URL?
    @Published var isLoading = false
    @Published var hasError = false
    @Published var errorMessage = ""
    
    // MARK: - Private Properties
    private let pokemonService = PokemonService()
    private var hasLoadedInitialData = false
    
    // MARK: - Initialization
    init() {
        Task {
            await loadInitialPokemon()
        }
    }
    
    // MARK: - Public Methods
    
    /// Load the first page of Pokemon
    func loadInitialPokemon() async {
        guard !hasLoadedInitialData else { return }
        
        isLoading = true
        hasError = false
        
        do {
            let response = try await pokemonService.fetchPokemonList(limit: 20, offset: 0)
            pokemon = response.results
            nextURL = response.nextURL
            hasLoadedInitialData = true
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    /// Fetch more Pokemon for infinite scroll
    func fetchMorePokemon() async {
        guard let nextURL = nextURL, !isLoading else { return }
        
        isLoading = true
        hasError = false
        
        do {
            let response = try await pokemonService.fetchPokemon(from: nextURL)
            pokemon.append(contentsOf: response.results)
            self.nextURL = response.nextURL
        } catch {
            hasError = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    /// Refresh the entire list
    func refresh() async {
        pokemon.removeAll()
        nextURL = nil
        hasLoadedInitialData = false
        await loadInitialPokemon()
    }
}
