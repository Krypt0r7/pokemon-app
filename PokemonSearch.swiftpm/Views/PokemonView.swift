
import SwiftUI

struct PokemonView: View {
    var name: String
    
    @State private var pokemon: PokemonDetails?
    
    let pokeService = PokemonService()
    
    var body: some View {
        VStack {
            if let pokemon {
                Text("\(pokemon.name.uppercased()) #\(pokemon.order)").font(.title2)
                HStack (spacing: 40) {
                    VStack (alignment: .leading) {
                        ForEach(pokemon.types, id: \.type.name){ detail in
                            Image(detail.type.name)
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                    AsyncImage(url: URL(string: pokemon.sprites.other.home?.frontDefault ?? ""), scale: 2.5)
                }
                HStack (spacing: 40) {
                    Label("\(String(pokemon.weight / 10)) kg", systemImage: "scalemass.fill")
                        .font(.title3)
                    Label("\(String(pokemon.height * 10)) cm", systemImage: "arrow.up.and.down")
                        .font(.title3)
                }
                
                List(pokemon.moves, id: \.move.name){ detail in
                    Text(detail.move.name.capitalizeFirstLetter())
                }
            } else {
                ProgressView()
                    .task{
                        do {
                            self.pokemon = try await pokeService.getPokemon(for: name)
                        } catch {
                            print("Not able to fetch", error)
                        }
                    }
            }
        }
       
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(name: "charmander")
    }
}
