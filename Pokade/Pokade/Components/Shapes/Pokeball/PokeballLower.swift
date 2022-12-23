//
//  Pokeball.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI

struct PokeballLower: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.maxX, rect.maxY)/2
        let innerRadius = radius/4
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(radians: .pi),
                endAngle: Angle(radians: .pi*2),
                clockwise: true)
            path.addArc(
                center: center,
                radius: innerRadius,
                startAngle: Angle(radians: 0),
                endAngle: Angle(radians: .pi*2),
                clockwise: true)
            path.move(to: CGPoint(
                x: rect.midX-radius,
                y: rect.midY))
            path.addLine(to: CGPoint(
                x: rect.midX-innerRadius,
                y: rect.midY))
            path.move(to: CGPoint(
                x: rect.midX+innerRadius,
                y: rect.midY))
            path.addLine(to: CGPoint(
                x: rect.midX+radius,
                y: rect.midY))
        }
    }
}
