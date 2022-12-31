//
//  GuessedTypesView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct GuessedTypesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var compact: Bool { horizontalSizeClass == .compact }
    var guessedTypes: [String]
    
    let types = SquirdleViewModel.typeColours
    
    var spacing: CGFloat = 1
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 50), spacing: spacing)],
            spacing: spacing)
        {
            ForEach(Array(types.keys), id: \.self) { type in
                let wrong: Bool = guessedTypes.contains(type)
                if compact {
                    TypeView(type: "\(type.prefix(1))", colour: types[type] ?? "#00000000")
                        .opacity(wrong ? 0.3 : 1)
                } else {
                    TypeView(type: type, colour: types[type] ?? "#00000000")
                        .opacity(wrong ? 0.3 : 1)
                }
            }
        }
    }
}

// MARK: Preview

struct GuessedTypesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessedTypesView(guessedTypes: SquirdleViewModel().guessedTypes)
    }
}
