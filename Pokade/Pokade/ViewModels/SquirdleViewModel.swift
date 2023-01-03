//
//  SquirdleViewModel.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI
import Combine

class SquirdleViewModel: ObservableObject, Identifiable {
    
    // MARK: Variables
    
    private(set) var id = UUID()
    @Published private(set) var model: Squirdle!
    @Published private(set) var latest = [PAPokemon]()
    static let typeColours = [
        "normal": "#A8A77A",
        "fire": "#EE8130",
        "water": "#6390F0",
        "electric": "#F7D02C",
        "grass": "#7AC74C",
        "ice": "#96D9D6",
        "fighting": "#C22E28",
        "poison": "#A33EA1",
        "ground": "#E2BF65",
        "flying": "#A98FF3",
        "psychic": "#F95587",
        "bug": "#A6B91A",
        "rock": "#B6A136",
        "ghost": "#735797",
        "dragon": "#6F35FC",
        "dark": "#705746",
        "steel": "#B7B7CE",
        "fairy": "#D685AD",
    ]
    
    var name: String = ""
    var guesses: [PAPokemon] {
        model.guesses
    }
    
    var guessedTypes: [String] {
        model.guessedTypes
    }
    
    init() {
        model = Squirdle(randomPokemon())
//        fetchPokemonList()
        print("Latest: \(latest)")
    }
    
    // MARK: Functions
    
    func guess(_ guess: String) {
        if guess.isEmpty {
            return
        }
        let pokemon = fetchPokemon(id: guess.lowercased())
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
        return fetchPokemon(id: "\(random)")
    }
    
    private func fetchPokemon(id: String) -> PAPokemon {
        let semaphore = DispatchSemaphore(value: 0)
        let fetcher = PokemonFetcher()
        var pokemon = Dummy.pokemon
        fetcher.getPokemon(id: id) { result in
            switch result {
            case .success(let value):
                pokemon = value
            case .failure(let error):
                print("Error: \(error)")
                pokemon = Dummy.pokemon
            }
            semaphore.signal()
        }
        semaphore.wait()
        return pokemon
    }
    
}
