
import Foundation

struct PokemonTypes: Codable {
    let results: [Result]
    
    struct Result: Codable {
        let name: String
        let url: String
    }
}

