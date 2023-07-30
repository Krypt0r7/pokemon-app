//
//  SwiftUIView.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var pokemonDetails: PokemonDetails?

    private let stringUtilities = StringUtilities()
    private let pokemonService = PokemonService()
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    if let details = pokemonDetails {
                        VStack {
                            Text("\(stringUtilities.capitalizeFirstLetter(details.name)) #\(details.order)" )
                                .font(.largeTitle)
                            
                            AsyncImage(url: URL(string: details.sprites.other.home.frontDefault), scale: 2)
                            Section(header: Text("Abilities").font(.headline)) {
                                List(details.abilities, id: \.ability.name) {ability in
                                    Text(ability.ability.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search for pokemon")
            .onSubmit(of: .search) {
                Task {
                    do {
                        self.pokemonDetails = try await pokemonService.getPokemon(for: searchText)
                    }
                }
            }
            .onChange(of: searchText) { value in
                if searchText.isEmpty {
                    pokemonDetails = nil
                }
            }
            .autocorrectionDisabled(true)
            
        }
        .padding()
    }
} 

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
