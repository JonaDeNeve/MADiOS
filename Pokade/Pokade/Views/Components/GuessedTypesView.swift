//
//  GuessedTypesView.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI

struct GuessedTypesView: View {
//    var type: PType
    var spacing: CGFloat = 1
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 10), spacing: spacing)],
            spacing: spacing)
        {
            TypeView()
        }
    }
}
                            
struct TypeView: View {
            
    var body: some View {
        Text("Type")
    }
}

struct GuessedTypesView_Previews: PreviewProvider {
    static var previews: some View {
        GuessedTypesView()
    }
}
