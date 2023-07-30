
import SwiftUI

struct PokemonView: View {
    var name: String
    
    @State private var pokemon: PokemonDetails?
    
    let pokeService = PokemonService()
    
    var body: some View {
        ScrollView {
            Text(pokemon?.name.uppercased() ?? "")
            AsyncImage(url: URL(string: pokemon?.sprites.other.home?.frontDefault ?? ""), scale: 2)
        }
        .task{
            do {
                self.pokemon = try await pokeService.getPokemon(for: name)
            } catch {
                print("Not able to fetch", error)
            }
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(name: "charmander")
    }
}
