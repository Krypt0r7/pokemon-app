//
//  SwiftUIView.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-27.
//

import SwiftUI

struct PokeTypes: View {
    @State private var pokeTypes: PokemonTypes?
    
    private let pokeService = PokemonService()

    let columns = [
           GridItem(.adaptive(minimum: 150))
       ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(pokeTypes?.results ?? [], id: \.name) { type in
                    NavigationLink(destination: TypePokemon(url: type.url, name: type.name)) {
                        HStack {
                            Image(type.name)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(type.name.uppercased())
                        }
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.cyan)
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

struct PokeTypes_Previews: PreviewProvider {
    static var previews: some View {
        PokeTypes()
    }
}
