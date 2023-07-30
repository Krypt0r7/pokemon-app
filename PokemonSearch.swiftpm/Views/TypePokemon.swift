

import SwiftUI

struct TypePokemon: View {
    let url: String
    let name: String
    
    @State private var pokeType: PokemonType?
    
    let stringUtil = StringUtilities()
    
    let pokeService = PokemonService()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(pokeType?.pokemon ?? [], id: \.pokemon.name){ pokemon in
                    NavigationLink(destination: Pokemon(name: pokemon.pokemon.name)){
                        Text(pokemon.pokemon.name.uppercased())
                        
                    }
                }
            }
        }
        .navigationTitle(stringUtil.capitalizeFirstLetter(name) + " pokemons")
        .task {
            do {
                self.pokeType = try await pokeService.getPokemonsByType(url: url)
            } catch {
                print("Not able to fetch")
            }
        }
    }
}
