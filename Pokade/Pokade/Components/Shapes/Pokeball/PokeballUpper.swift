//
//  PokeballUpper.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//


import SwiftUI

struct PokeballUpper: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.maxX, rect.maxY)/2
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(radians: 0),
                endAngle: Angle(radians: .pi),
                clockwise: true)
        }
    }
}
