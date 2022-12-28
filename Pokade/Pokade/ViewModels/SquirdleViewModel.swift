//
//  SquirdleViewModel.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import Foundation
import Combine

class SquirdleViewModel: ObservableObject, Identifiable {
    
    private(set) var id = UUID()
    @Published private(set) var model: Squirdle!
    
    var guesses: [PAPokemon] {
        model.guesses
    }
    
    init() {
        model = Squirdle(randomPokemon())
    }
    
    func guess(_ guess: String) {
        if guess.isEmpty {
            return
        }
        let pokemon = fetchPokemon(pokemon: guess)
        print(pokemon)
        model.guess(guess: pokemon)
    }
    
    func compare(pokemon: PAPokemon) -> [PokeballStatus] {
        return model.compare(pokemon)
    }
    
    func newGame() {
        model = Squirdle(randomPokemon())
    }
    
    func randomPokemon() -> PAPokemon {
        var random = Int.random(in: 1..<1153)
        if random < 905 {
            random += 95
        }
        return fetchPokemon(pokemon: "\(random)")
//        PAPokemon(id: 1, name: "Squirtle", type1: "blank", type2: "Water", height: 5, weight: 89, game_index: 0)
    }
    
    private func fetchPokemon(pokemon: String) -> PAPokemon {
        var value: Set<PAPokemon> = []
        pAResultsCancellable = nil
        pARequest?.stopFetching()
        pARequest = nil
        
        pARequest = PokemonRequest.create(pokemon: pokemon)
        pARequest?.fetch(andRepeatEvery: 0)
        pAResultsCancellable = pARequest?.results.sink { results in
            value = results
        }
        return value.first ?? PAPokemon(id: 0, name: "MissingNo.", type1: "", type2: "", height: 0, weight: 0, game_index: 0)
    }
    
    private(set) var pARequest: PokemonRequest!
    private var pAResultsCancellable: AnyCancellable?
    
}
