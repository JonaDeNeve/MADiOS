//
//  PokemonDetailView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PAPokemon
    let types = SquirdleViewModel.typeColours
    
    var body: some View {
        VStack {
            HStack {
                Text(pokemon.name)
                Text("#\(pokemon.id)")
            }
            .font(.largeTitle)
            Text("Generation: \(pokemon.gen)")
            Text("Type")
            HStack {
                TypeView(type: pokemon.type1,
                         colour: types[pokemon.type1] ?? "#00000000")
                TypeView(type: pokemon.type2,
                         colour: types[pokemon.type2] ?? "#00000000")
            }
            Text("Height: \(pokemon.height)")
            Text("Weight: \(pokemon.weight)")
        }
    }
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
    }
}

// MARK: Preview

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(Dummy.pokemon)
    }
}
