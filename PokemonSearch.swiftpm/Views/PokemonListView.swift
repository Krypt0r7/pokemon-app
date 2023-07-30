
import SwiftUI

struct PokemonListView: View {
    let url: String
    let name: String
    
    @State private var pokemonType: PokemonType?
    
    private let pokeService = PokemonService()

    var body: some View {
        Group {
            if let pokemonType {
                List(pokemonType.pokemon, id: \.pokemon.name){ result in
                    NavigationLink(result.pokemon.name.uppercased()) {
                        PokemonView(name: result.pokemon.name)
                    }
                }
            } else {
                ProgressView()
                    .task {
                        do {
                            self.pokemonType = try await pokeService.getPokemonsByType(url: url)
                        } catch {
                            print("Not able to fetch", error)
                        }
                    }
            }
        }
        .navigationTitle(name.capitalizeFirstLetter() + " pokemons")
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(url: "https://pokeapi.co/api/v2/type/rock", name: "rock")
    }
}
