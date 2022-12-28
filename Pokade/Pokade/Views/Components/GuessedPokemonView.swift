//
//  GuessedPokemonView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct GuessedPokemonView: View {
    var pokemon: PAPokemon
    var status: [PokeballStatus]
    
    var body: some View {
        VStack {
            HStack(spacing: 1) {
                Pokeball(status: status[0])
                Pokeball(status: status[1])
                Pokeball(status: status[2])
                Pokeball(status: status[3])
                Pokeball(status: status[4])
            }
            .scaledToFit()
            .padding(.top)
            Text("\(pokemon.name)")
            Divider()
        }
        .padding(.horizontal)
    }
    
    init(_ status: [PokeballStatus], _ pokemon: PAPokemon) {
        self.pokemon = pokemon
        self.status = status
    }
}

struct GuessedPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        GuessedPokemonView(
            [.incorrect, .wrongPosition, .incorrect, .lower, .higher],
            PAPokemon(id: 1, name: "Squirtle", type1: "Blank", type2: "Water", height: 5, weight: 89, game_index: 0))
    }
}
