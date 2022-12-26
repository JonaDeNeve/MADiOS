//
//  SquirdleModel.swift
//  Pokade
//
//  Created by Jona De Neve on 23/12/2022.
//

import Foundation

struct Squirdle {
    var pokemon = Pokemon(name: "Squirtle", gen: 1, type1: "blank", type2: "Water", height: 5, weight: 89)
    var guesses = [Pokemon]()
    
    init() {
        pokemon = randomPokemon()
    }
    
    mutating func addGuess() {
//        guesses.append(Pokemon())
    }
    
    func randomPokemon() -> Pokemon {
        Pokemon(name: "Squirtle", gen: 1, type1: "blank", type2: "Water", height: 5, weight: 89)
    }
}
