//
//  SquirdleView.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI
struct SquirdleView: View {
    @ObservedObject var squirdle: SquirdleViewModel
    @State private var guess = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                HStack() {
                    Text("Id")
                        .frame(maxWidth: .infinity)
                    Text("Type 1")
                        .frame(maxWidth: .infinity)
                    Text("Type 2")
                        .frame(maxWidth: .infinity)
                    Text("Height")
                        .frame(maxWidth: .infinity)
                    Text("Weight")
                        .frame(maxWidth: .infinity)
                }
                .font(calculateFont(for: geo, with: 0.05))
                .padding(.horizontal)
                ScrollView {
                    ForEach(squirdle.guesses.reversed()) { pokemon in
                        NavigationLink {
                            PokemonDetailView(pokemon)
                        } label: {
                            GuessedPokemonView(squirdle.compare(pokemon: pokemon), pokemon)
                                .foregroundColor(.primary)
                        }
                    }
                }
                GuessedTypesView(guessedTypes: squirdle.guessedTypes)
                    .padding(.horizontal)
                HStack {
                    TextField("Guess", text: $guess)
                    Button("Submit") {
                        squirdle.guess(guess)
                        guess = ""
                    }
                }
                .font(calculateFont(for: geo, with: 0.05))
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func calculateFont(for geo: GeometryProxy, with scale: CGFloat) -> Font {
        Font.system(size: geo.size.width * scale)
    }
    
    init(_ squirdle: SquirdleViewModel) {
        self.squirdle = squirdle
    }
}

// MARK: Preview

struct SquirdleView_Previews: PreviewProvider {
    static var previews: some View {
        SquirdleView(SquirdleViewModel())
    }
}
