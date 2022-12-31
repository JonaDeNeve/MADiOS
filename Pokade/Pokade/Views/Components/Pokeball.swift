//
//  Pokeball.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI

struct Pokeball: View {
    
    
    var status: PokeballStatus
    
    //Constants
    let lineWidth: CGFloat = 3
    let scale: CGFloat = 0.4
    
    
    var body: some View {
        GeometryReader{ geo in
            let x = geo.size.height/15
            ZStack {
                PokeballUpper(x)
                    .stroke(lineWidth: lineWidth)
                    .background(PokeballUpper(x).fill(getColor()))
                PokeballLower(x)
                    .stroke(lineWidth: lineWidth)
                    .background(PokeballLower(x).fill(.white))
                Group {
                    switch status {
                    case .correct:
                        Image(systemName: "checkmark")
                    case .incorrect:
                        Image(systemName: "xmark")
                    case .higher:
                        Image(systemName: "triangle.fill")
                    case .lower:
                        Image(systemName: "triangle.fill")
                            .rotationEffect(.radians(.pi))
                    case .wrongPosition:
                        Image(systemName: "arrow.left.arrow.right")
                    }
                }
                .font(iconFont(for: geo))
                .offset(y: -geo.size.height/6.8)
                .foregroundColor(.white)
            }
            .foregroundColor(.black)
        }
    }
    
    private func iconFont(for geometry: GeometryProxy) -> Font {
        Font.system(size: min(geometry.size.width, geometry.size.height) * scale)
    }
    
    func getColor() -> Color {
        var color: Color
        switch status {
        case .correct:
            color = Color.green
        case .incorrect:
            color = Color.red
        case .higher:
            color = Color.blue
        case .lower:
            color = Color.blue
        case .wrongPosition:
            color = Color.orange
        }
        return color
    }
}

// MARK: Preview

struct Pokeball_Previews: PreviewProvider {
    static var previews: some View {
        Pokeball(status: .correct)
//            .frame(width: 100, height: 100)
    }
}
