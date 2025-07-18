import SwiftUI

struct PokemonTypeListView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var pokeTypes: PokemonTypes?
    @State private var isLoading = true
    
    private let pokeService = PokemonService()

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        Group {
            if isLoading {
                // Loading state
                VStack(spacing: 16) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Loading Pokemon Types...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredTypes, id: \.name) { type in
                            NavigationLink(destination: PokemonListView(url: type.url, name: type.name)) {
                                TypeCardView(typeName: type.name)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
        }
        .navigationTitle("Pokemon Types")
        .task {
            await loadTypes()
        }
    }
    
    // Filter out unknown and shadow types
    private var filteredTypes: [PokemonTypes.Result] {
        pokeTypes?.results.filter { type in
            type.name != "unknown" && type.name != "shadow"
        } ?? []
    }
    
    private func loadTypes() async {
        do {
            self.pokeTypes = try await pokeService.getTypes()
            isLoading = false
        } catch {
            print("❌ Error fetching types: \(error)")
            isLoading = false
        }
    }
}

// MARK: - Type Card Component
struct TypeCardView: View {
    let typeName: String
    
    var body: some View {
        VStack(spacing: 12) {
            // Type icon
            Image(typeName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            // Type name
            Text(typeName.uppercased())
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 12)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [typeColor, typeColor.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: typeColor.opacity(0.3), radius: 8, x: 0, y: 4)
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.2), value: typeName)
    }
    
    // Color mapping for each Pokemon type
    private var typeColor: Color {
        switch typeName.lowercased() {
        case "normal": return Color.gray
        case "fire": return Color.red
        case "water": return Color.blue
        case "electric": return Color.yellow
        case "grass": return Color.green
        case "ice": return Color.cyan
        case "fighting": return Color.red.opacity(0.8)
        case "poison": return Color.purple
        case "ground": return Color.brown
        case "flying": return Color.indigo
        case "psychic": return Color.pink
        case "bug": return Color.green.opacity(0.7)
        case "rock": return Color.brown.opacity(0.8)
        case "ghost": return Color.purple.opacity(0.7)
        case "dragon": return Color.indigo.opacity(0.8)
        case "dark": return Color.black.opacity(0.8)
        case "steel": return Color.gray.opacity(0.8)
        case "fairy": return Color.pink.opacity(0.8)
        default: return Color.gray
        }
    }
}

struct PokemonTypeListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeListView()
    }
}
