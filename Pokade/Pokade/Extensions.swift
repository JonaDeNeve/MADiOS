//
//  Extensions.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import SwiftUI


extension CGPoint {
    
    static func + (lhs: Self, rhs: Self) -> Self {
        Self(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        Self(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func += (lhs: inout Self, rhs: Self) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    static func * (lhs: Self, rhs: CGFloat) -> Self {
        Self(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func / (lhs: Self, rhs: CGFloat) -> Self {
        Self(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

//Overgenomen uit EmojiArt project Extensions.swift
extension CGSize {
    
    static func + (lhs: Self, rhs: Self) -> Self {
        Self(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func += (lhs: inout Self, rhs: Self) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }
    
    static func * (lhs: Self, rhs: CGFloat) -> Self {
        Self(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    
    static func / (lhs: Self, rhs: CGFloat) -> Self {
        Self(width: lhs.width / rhs, height: lhs.height / rhs)
    }
}
