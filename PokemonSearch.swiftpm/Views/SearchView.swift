
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var toBeSearched = ""
    @State private var pokemonDetails: PokemonDetails?

    private let pokemonService = PokemonService()
    
    // Popular Pokemon for quick access
    private let popularPokemon = [
        "pikachu", "charizard", "blastoise", "venusaur",
        "mewtwo", "mew", "lugia", "ho-oh",
        "rayquaza", "arceus", "lucario", "garchomp"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            if toBeSearched != "" {
                PokemonView(name: toBeSearched)
            } else {
                // Instructions and popular Pokemon section
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Instructions section
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                Text("How to Search")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            
                            Text("Enter the exact Pokemon name to search. Names should be lowercase without spaces.")
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Examples:")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                HStack {
                                    Text("✓ pikachu")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text("✗ Pikachu")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("✓ charizard")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text("✗ Char izard")
                                        .foregroundColor(.red)
                                }
                            }
                            .font(.caption)
                            .padding(.leading, 8)
                        }
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(12)
                        
                        // Popular Pokemon section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Popular Pokemon")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("Tap any name below to search quickly:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                ForEach(popularPokemon, id: \.self) { pokemon in
                                    Button(action: {
                                        searchText = pokemon
                                        toBeSearched = pokemon
                                    }) {
                                        Text(pokemon.capitalized)
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(Color(.systemBackground))
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(.systemGray4), lineWidth: 1)
                                            )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
            }
        }
        .navigationTitle("Search")
        .searchable(text: $searchText, prompt: "Enter exact Pokemon name (e.g., pikachu)")
        .onSubmit(of: .search) {
            if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                toBeSearched = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        .onChange(of: searchText) { value in
            if searchText.isEmpty {
                toBeSearched = ""
            }
        }
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
    }
} 

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
