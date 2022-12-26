//
//  PAPokemon.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import Foundation

struct Pokemon: Identifiable {
    let id = UUID()
    let name: String
    let gen: Int
    let type1: String
    let type2: String
    let height: Int
    let weight: Int
}

