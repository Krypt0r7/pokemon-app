import Foundation

// MARK: - Individual Pokemon Model
struct Pokemon: Codable, Identifiable {
    let name: String
    let url: String
    
    // Computed property to extract Pokemon ID from URL
    var id: Int {
        let components = url.components(separatedBy: "/")
        return Int(components[components.count - 2]) ?? 0
    }
    
    // Computed property to get Pokemon artwork URL
    var artworkURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
}

// MARK: - Paginated Response Model
struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
    
    // Computed property to get next URL as URL type
    var nextURL: URL? {
        guard let next = next else { return nil }
        return URL(string: next)
    }
}
