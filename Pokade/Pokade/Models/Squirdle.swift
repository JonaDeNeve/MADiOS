//
//  SquirdleModel.swift
//  Pokade
//
//  Created by Jona De Neve on 23/12/2022.
//

import Foundation

struct Squirdle {
    private(set) var pokemon: PAPokemon
    private(set) var guesses = [PAPokemon]()
    private(set) var guessedTypes = [String]()
    private(set) var isComplete = false
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
        print(pokemon)
    }
    
    mutating func guess(guess: PAPokemon) {
        guesses.append(guess)
        addTypeGuess(guess.type1)
        addTypeGuess(guess.type2)
        if guess == self.pokemon {
            isComplete = true
        }
    }
    
    mutating func addTypeGuess(_ type: String) {
        if !guessedTypes.contains(type) && type != pokemon.type1  && type != pokemon.type2 {
            guessedTypes.append(type)
        }
    }
    
    func compare(_ pokemon: PAPokemon) -> [PokeballStatus] {
        if self.pokemon == pokemon {
            return [.correct, .correct, .correct, .correct, .correct]
        }
        return self.pokemon.compare(pokemon)
    }
}
