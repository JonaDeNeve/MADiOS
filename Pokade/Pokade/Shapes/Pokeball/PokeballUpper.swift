//
//  PokeballUpper.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//


import SwiftUI

struct PokeballUpper: Shape {
    var offset: CGFloat
    
    init(_ offset: CGFloat) {
        self.offset = offset
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.maxX, rect.maxY)/2
        let innerRadius = radius/4
        let centerOffset = rect.maxY/offset
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(radians: 0),
                endAngle: Angle(radians: .pi),
                clockwise: true)
            path.addLine(to: CGPoint(
                x: rect.midX-innerRadius,
                y: rect.midY+centerOffset))
            path.addArc(
                center: center + CGPoint(x: 0, y: centerOffset),
                radius: innerRadius,
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians: 0),
                clockwise: false)
            path.addLine(to: CGPoint(
                x: rect.midX+radius,
                y: rect.midY))
        }
    }
}

struct Previews_PokeballUpper_Previews: PreviewProvider {
    static var previews: some View {
        PokeballUpper(8)
            .fill(.red)
    }
}
