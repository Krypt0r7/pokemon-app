import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let height: Int
    let order: Int
    let weight: Int
    let sprites: Sprites
    let abilities: [Ability]
    let moves: [MoveDetails]
    let types: [TypeDetails]
}

struct Ability: Codable {
    let ability: AbilityDetails
}

struct AbilityDetails: Codable {
    let name: String
}

struct Home: Codable {
    let frontDefault: String?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Other: Codable {
    let home: Home?
}


struct Sprites: Codable {
    let other: Other
}

struct MoveDetails: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String
    let url: URL
}

struct TypeDetails: Codable {
    let slot: Int
    let type: Type
}

struct Type: Codable {
    let name: String
    let url: URL
}
