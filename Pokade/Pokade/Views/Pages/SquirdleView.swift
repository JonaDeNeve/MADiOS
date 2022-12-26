//
//  SquirdleView.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI
struct SquirdleView: View {
    @ObservedObject var squirdle: SquirdleViewModel
    
    var body: some View {
        GeometryReader { geo in
            VStack() {
                HStack(spacing: 4) {
                    Text("Gen")
                    Text("Type 1")
                    Text("Type 2")
                    Text("Height")
                    Text("Weight")
                }
                .font(tableHeaderFont(for: geo))
                .padding(.horizontal)
                ScrollView {
                    GuessedPokemonView()
                    GuessedPokemonView()
                    GuessedPokemonView()
                    GuessedPokemonView()
                    GuessedPokemonView()
                    GuessedPokemonView()
                    GuessedPokemonView()
                }
                GuessedTypesView()
                    .padding(.horizontal)
                HStack {
                    Text("Test")
                    Button("Submit") {
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func tableHeaderFont(for geometry: GeometryProxy) -> Font {
        Font.system(size: geometry.size.width * 0.06)
    }
}

struct SquirdleView_Previews: PreviewProvider {
    static var previews: some View {
        SquirdleView(squirdle: SquirdleViewModel())
    }
}
