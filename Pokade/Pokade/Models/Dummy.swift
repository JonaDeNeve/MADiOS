//
//  Dummy.swift
//  Pokade
//
//  Created by Jona De Neve on 29/12/2022.
//

import Foundation

struct Dummy {
    static let pokemon = PAPokemon(
        id: 0,
        name: "MissingNo.",
        types: [
            PAPokemonType(
                slot: 1,
                type: NamedAPIResource(
                    name: "normal",
                    url: "")),
            PAPokemonType(
                slot: 2,
                type: NamedAPIResource(
                    name: "blank",
                    url: ""))],
        height: 10,
        weight: 95,
        game_indices: [
        PAVersionGameIndex(
            game_index: 1,
            version: NamedAPIResource(
                name: "Red",
                url: ""))])
}
