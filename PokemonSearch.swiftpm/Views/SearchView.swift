
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var toBeSearched = ""
    @State private var pokemonDetails: PokemonDetails?

    private let pokemonService = PokemonService()
    var body: some View {
        VStack {
            if toBeSearched != "" {
                PokemonView(name: toBeSearched)
            }
        }
        .navigationTitle("Search")
        .searchable(text: $searchText, prompt: "Search for pokemon")
        .onSubmit(of: .search) {
           toBeSearched = searchText
        }
        .onChange(of: searchText) { value in
            if searchText.isEmpty {
                toBeSearched = ""
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
