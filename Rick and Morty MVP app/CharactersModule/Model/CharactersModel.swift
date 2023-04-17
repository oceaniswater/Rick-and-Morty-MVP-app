//
//  CharactersModel.swift
//  Rick and Morty MVP app
//
//  Created by Mark Golubev on 29/03/2023.
//

import Foundation

// MARK: - Characters
struct CharactersModel: Codable {
    let info: Info?
    let results: [Character]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: JSONNull?
}

// MARK: - Result
struct Character: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

// MARK: - Location
class Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case animal = "Animal"
    case humanoid = "Humanoid"
    case cronenberg = "Cronenberg"
    case poopybutthole = "Poopybutthole"
    case mythologicalCreature = "Mythological Creature"
    case robot = "Robot"
    case disease = "Disease"
    case unknown = "unknown"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
