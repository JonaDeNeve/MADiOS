//
//  PokemonDetailView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PAPokemon
    
    var body: some View {
        Text("TO DO: Pokedex")
            .scaleEffect(2)
    }
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(PAPokemon(id: 1, name: "Squirtle", type1: "blank", type2: "Water", height: 5, weight: 89, game_index: 0))
    }
}
