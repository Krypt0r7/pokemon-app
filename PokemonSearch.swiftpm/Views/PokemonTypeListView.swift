
import SwiftUI

struct PokemonTypeListView: View {
    @State private var pokeTypes: PokemonTypes?
    
    private let pokeService = PokemonService()

    let columns = [
           GridItem(.adaptive(minimum: 150))
       ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(pokeTypes?.results ?? [], id: \.name) { type in
                    NavigationLink(destination: PokemonListView(url: type.url, name: type.name)) {
                        HStack {
                            Image(type.name)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(type.name.uppercased())
                        }
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.secondary)
                    .cornerRadius(.infinity)

                }
            }
        }
        .navigationTitle("Pokemon types")
        .task {
            do {
                self.pokeTypes = try await pokeService.getTypes()
            } catch {
                print("Not able to fetch")
            }
        }
    }
}

struct PokemonTypeListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeListView()
    }
}
