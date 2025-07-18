import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let height: Int
    let order: Int
    let weight: Int
    let baseExperience: Int?
    let sprites: Sprites
    let abilities: [Ability]
    let moves: [MoveDetails]
    let types: [TypeDetails]
    let stats: [StatDetails]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, height, order, weight, sprites, abilities, moves, types, stats
        case baseExperience = "base_experience"
    }
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

struct StatDetails: Codable {
    let baseStat: Int
    let effort: Int
    let stat: Stat
    
    private enum CodingKeys: String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}

struct Stat: Codable {
    let name: String
    let url: URL
}
