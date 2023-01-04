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
            Group {
                VStack(spacing: 10) {
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
            }
            .detailify(pokemon: pokemon)
        }
    
    init(_ pokemon: PAPokemon) {
        self.pokemon = pokemon
    }
}

extension View {
    func detailify(pokemon: PAPokemon) -> some View {
            self.modifier(Detailify(pokemon))
    }
}

// MARK: CompactableIntoContextMenu
//Copied from L16 EmojiArt


struct Detailify: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var hCompact: Bool { horizontalSizeClass == .compact }
    var vCompact: Bool { verticalSizeClass == .compact }
    
    var pokemon: PAPokemon
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            if hCompact && !vCompact {
                VStack {
                    title
                    image
                    content
                    description
                }
            } else {
                HStack {
                    image
                        .frame(width: geo.size.width * 0.4)
                    VStack {
                        title
                        content
                    }
                }
                description
            }
        }
    }
    
    let shape = RoundedRectangle(cornerRadius: 5)
    
    var title: some View {
        return ZStack {
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
    }
    
    var image: some View {
        AsyncImage(url: URL(string: pokemon.image)) {
            $0.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }
    
    var description: some View {
        GeometryReader { geo in
            ZStack {
                shape.stroke()
                HStack {
                    shape
                        .fill(.red)
                        .frame(width: geo.size.width/20)
                    Spacer()
                    Text(pokemon.description)
                    Spacer()
                    shape
                        .fill(.red)
                        .frame(width: geo.size.width/20)
                }
            }
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
