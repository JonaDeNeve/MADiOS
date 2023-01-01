//
//  PAPokemon.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import Foundation

struct PAPokemon: Codable, Hashable, Identifiable, Comparable, CustomStringConvertible {
    
    // MARK: Variables
    
    var id: Int
    var name: String
    var types: [PAPokemonType]
    var height: Int
    var weight: Int
    var sprites: PASprites
    
    var type1: String { types[0].type.name }
    var type2: String {
        types.count == 2 ? types[1].type.name : "blank"
    }
    var image: String { sprites.front_default }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, types, height, weight, sprites
    }
    
    // MARK: Functions
    
    func compare(_ guess: Self) -> [PokeballStatus] {
        var status: [PokeballStatus] = []
        status.append(compareInt(id, guess.id))
        let types = compareTypes(guess)
        status.append(types[0])
        status.append(types[1])
        status.append(compareInt(height, guess.height))
        status.append(compareInt(weight, guess.weight))
        return status
    }
    
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func ==(lhs: PAPokemon, rhs: PAPokemon) -> Bool { lhs.id == rhs.id }
    static func < (lhs: PAPokemon, rhs: PAPokemon) -> Bool { lhs.id < rhs.id }

    var description: String {
        return "#\(id) \(name) \(type1) \(type2) \(height) \(weight)"
    }
    
    func compareTypes(_ x: Self) -> [PokeballStatus] {
        var status: [PokeballStatus] = []
        if type1 == x.type1 {
            status.append(.correct)
        }
        else if type2 == x.type1 {
            status.append(.wrongPosition)
        }
        else {
            status.append(.incorrect)
        }
        if type2 == x.type2 {
            status.append(.correct)
        }
        else if type1 == x.type2 {
            status.append(.wrongPosition)
        }
        else {
            status.append(.incorrect)
        }
        return status
    }
    
    func compareInt(_ x: Int, _ y: Int) -> PokeballStatus {
        if x == y {
            return .correct
        }
        else if x < y {
            return .lower
        }
        else {
            return .higher
        }
    }
}


// MARK: PAPokemonType

struct PAPokemonType: Codable {
    var slot: Int
    var type: NamedAPIResource<Any>
    
    private enum CodingKeys: String, CodingKey {
        case slot, type
    }
}


// MARK: PAVersionGameIndex

struct PAVersionGameIndex: Codable {
    var game_index: Int
    var version: NamedAPIResource<Any>
    
    private enum CodingKeys: String, CodingKey {
        case game_index, version
    }
}

// MARK: NamedAPIResource

struct NamedAPIResource<T>: Codable {
    var name: String
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case name, url
    }
}

// MARK: PokemonSprites

struct PASprites: Codable {
    var front_default: String
    
    private enum CodingKeys: String, CodingKey {
        case front_default
    }
}
