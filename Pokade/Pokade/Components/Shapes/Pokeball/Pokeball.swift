//
//  Pokeball.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI

struct Pokeball: View {
    var status: PokeballStatus
    var color: Color = .red
//    switch status {
//    case .correct:
//        .green
//    case .higher, .lower:
//        .blue
//    case .wrongPosition:
//        .yellow
//    case .incorrect:
//        .red
//    default:
//        .red
//    }
    let lineWidth = CGFloat(3)
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                PokeballUpper()
                    .stroke(lineWidth: lineWidth)
                    .background(PokeballUpper().fill(color))
                PokeballLower()
                    .stroke(lineWidth: lineWidth)
                    .background(PokeballLower().fill(.white))
                Circle()
                    .stroke(lineWidth: lineWidth/2)
                    .scale(0.16)
            }
        }
    }
}

struct Pokeball_Previews: PreviewProvider {
    static var previews: some View {
        Pokeball(status: .correct)
    }
}
