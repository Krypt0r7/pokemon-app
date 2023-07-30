
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var pokemonDetails: PokemonDetails?

    private let pokemonService = PokemonService()
    var body: some View {
        VStack {
            if let details = pokemonDetails {
                VStack {
                    Text("\(details.name.capitalizeFirstLetter()) #\(details.order)" )
                        .font(.largeTitle)
                    
                    AsyncImage(url: URL(string: details.sprites.other.home?.frontDefault ?? ""), scale: 2)
                    Section(header: Text("Abilities").font(.headline)) {
                        List(details.abilities, id: \.ability.name) {ability in
                            Text(ability.ability.name)
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
} 

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
