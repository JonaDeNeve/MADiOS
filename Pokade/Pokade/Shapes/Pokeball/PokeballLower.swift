//
//  Pokeball.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI

struct PokeballLower: Shape {
    var offset: CGFloat
    
    init(_ offset: CGFloat) {
        self.offset = offset
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.maxX, rect.maxY)/2
        let innerRadius = radius/4
        let centerOffset = min(rect.maxX, rect.maxY)/offset
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians: .pi*2),
                clockwise: true)
            path.addLine(to: CGPoint(
                x: rect.midX+innerRadius,
                y: rect.midY+centerOffset))
            path.addArc(
                center: center + CGPoint(x: 0, y: centerOffset),
                radius: innerRadius,
                startAngle: Angle(radians: 0),
                endAngle: Angle(radians: .pi*3),
                clockwise: false)
            path.addLine(to: CGPoint(
                x: rect.midX-radius,
                y: rect.midY))
            path.move(to: center + CGPoint(x: innerRadius/2, y: centerOffset))
            path.addArc(
                center: center + CGPoint(x: 0, y: centerOffset),
                radius: innerRadius/2,
                startAngle: Angle(radians: 0),
                endAngle: Angle(radians: .pi*2),
                clockwise: false)
        }
    }
}

struct Previews_PokeballLower_Previews: PreviewProvider {
    static var previews: some View {
        PokeballLower(8)
            .stroke(lineWidth: 2)
//            .frame(width: 50, height: 50)
    }
}
