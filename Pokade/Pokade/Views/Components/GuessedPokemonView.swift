//
//  GuessedPokemonView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct GuessedPokemonView: View {
    var body: some View {
        VStack {
            HStack(spacing: 1) {
                Pokeball(status: .correct)
                Pokeball(status: .incorrect)
                Pokeball(status: .wrongPosition)
                Pokeball(status: .lower)
                Pokeball(status: .higher)
            }
            .scaledToFit()
            Text("Charmander")
        }
        .padding(.horizontal)
        Divider()
    }
}

struct GuessedPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        GuessedPokemonView()
    }
}
