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
        let shape = RoundedRectangle(cornerRadius: 5)
        GeometryReader { geo in
                AsyncImage(url: URL(string: pokemon.image)) {
                    $0.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.5)
                VStack(spacing: 10) {
                    ZStack{
                        shape.fill(.red)
                        shape.stroke()
                        HStack {
                            Pokeball(status: .normal)
                                .background(Circle().stroke(.white, lineWidth: 10))
                                .frame(width: 30, height: 30)
                            Text("\(pokemon.id)")
                            Spacer()
                            Text(pokemon.name.capitalized)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 50)
                    HStack {
                        TypeView(type: pokemon.type1,
                                 colour: types[pokemon.type1] ?? "#00000000")
                        TypeView(type: pokemon.type2,
                                 colour: types[pokemon.type2] ?? "#00000000")
                    }
                    ZStack{
                        shape.stroke()
                        VStack {
                            Text("HT: \(pokemon.height)")
                            Divider()
                            Text("WT: \(pokemon.weight)")
                        }
                    }
                }
                .detailify()
        }
    }
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
    }
}

extension View {
    func detailify() -> some View {
            self.modifier(Detailify())
    }
}

// MARK: CompactableIntoContextMenu
//Copied from L16 EmojiArt


struct Detailify: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var compact: Bool { horizontalSizeClass == .compact }
    
    func body(content: Content) -> some View {
        if compact {
            VStack {
                content
            }
        } else {
            HStack {
                content
            }
        }
    }
}

// MARK: Preview

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(Dummy.pokemon)
    }
}
