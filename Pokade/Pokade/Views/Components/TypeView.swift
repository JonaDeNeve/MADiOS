//
//  TypeView.swift
//  Pokade
//
//  Created by Jona De Neve on 30/12/2022.
//

import SwiftUI

struct TypeView: View {
    var type: String
    var colour: String
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 5)
            .fill(Color(hex: colour))
        Group {
            if type != "blank" {
                Text(type.capitalized)
                    .font(.title2)
                    .padding(8)
            }
        }
        .background(shape)
        .foregroundColor(.white)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(type: "Fire", colour: "#FF0000")
    }
}
