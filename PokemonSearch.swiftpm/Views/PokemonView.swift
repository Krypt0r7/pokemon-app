
import SwiftUI

struct PokemonView: View {
    var name: String
    
    @State private var pokemon: PokemonDetails?
    
    let pokeService = PokemonService()
    
    @ObservedObject private var favoriteService = FavoriteService.shared

    var body: some View {
        ScrollView {
            if let pokemon {
                VStack(spacing: 24) {
                    // Header with name and favorite button
                    HStack {
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                let imageUrl = pokemon.sprites.other.home?.frontDefault ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png"
                                favoriteService.toggleFavourite(UserDataModel.Favourite(pokemon.name, imageUrl))
                            }
                        }) {
                            Image(systemName: favoriteService.pokemonIsFavourite(pokemon.name) ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(favoriteService.pokemonIsFavourite(pokemon.name) ? .red : .gray)
                                .scaleEffect(favoriteService.pokemonIsFavourite(pokemon.name) ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: favoriteService.pokemonIsFavourite(pokemon.name))
                        }
                    }
                    .padding(.horizontal)
                    
                    // Pokemon artwork
                    AsyncImage(url: URL(string: pokemon.sprites.other.home?.frontDefault ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.3))
                            .overlay {
                                ProgressView()
                                    .scaleEffect(1.2)
                            }
                    }
                    .frame(width: 200, height: 200)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // Type badges
                    HStack(spacing: 12) {
                        ForEach(pokemon.types, id: \.type.name) { typeDetail in
                            Text(typeDetail.type.name.capitalized)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(colorForType(typeDetail.type.name))
                                .cornerRadius(20)
                        }
                    }
                    
                    // Basic Info Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Basic Info")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 40) {
                            VStack {
                                Text("Height")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(pokemon.height)m")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                            VStack {
                                Text("Weight")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(pokemon.weight)kg")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            
                            VStack {
                                Text("Base Experience")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("\(pokemon.baseExperience ?? 0)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Base Stats Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Base Stats")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            ForEach(pokemon.stats, id: \.stat.name) { statDetail in
                                StatRowView(statName: statDetail.stat.name, statValue: statDetail.baseStat)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Abilities Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Abilities")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 8) {
                            ForEach(pokemon.abilities, id: \.ability.name) { abilityDetail in
                                HStack {
                                    Text(abilityDetail.ability.name.capitalized)
                                        .font(.body)
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            } else {
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.5)
                    Text("Loading \(name.capitalized)...")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .task {
                    do {
                        self.pokemon = try await pokeService.getPokemon(for: name)
                    } catch {
                        print("Not able to fetch", error)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to get color for Pokemon type
    private func colorForType(_ type: String) -> Color {
        switch type.lowercased() {
        case "grass": return .green
        case "poison": return .purple
        case "fire": return .red
        case "water": return .blue
        case "electric": return .yellow
        case "psychic": return .pink
        case "ice": return .cyan
        case "dragon": return .indigo
        case "dark": return .black
        case "fairy": return Color(red: 1.0, green: 0.7, blue: 0.8)
        case "fighting": return .brown
        case "ground": return Color(red: 0.8, green: 0.6, blue: 0.4)
        case "rock": return Color(red: 0.7, green: 0.6, blue: 0.5)
        case "bug": return Color(red: 0.6, green: 0.8, blue: 0.2)
        case "ghost": return Color(red: 0.4, green: 0.3, blue: 0.6)
        case "steel": return Color(red: 0.6, green: 0.6, blue: 0.7)
        case "flying": return Color(red: 0.5, green: 0.7, blue: 1.0)
        case "normal": return .gray
        default: return .gray
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(name: "charmander")
    }
}
