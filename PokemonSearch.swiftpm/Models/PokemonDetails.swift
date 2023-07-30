import Foundation

struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let height: Int
    let order: Int
    let weight: Int
    let sprites: Sprites
    let abilities: [Ability]
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
