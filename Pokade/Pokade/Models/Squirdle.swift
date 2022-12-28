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
    private(set) var isComplete = false
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
        print(pokemon)
    }
    
    mutating func guess(guess: PAPokemon) {
        guesses.append(guess)
        if guess == self.pokemon {
            isComplete = true
        }
    }
    
    func compare(_ pokemon: PAPokemon) -> [PokeballStatus] {
        if self.pokemon == pokemon {
            return [.correct, .correct, .correct, .correct, .correct]
        }
        return self.pokemon.compare(pokemon)
    }
}
