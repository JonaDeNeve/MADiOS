//
//  PA+Pokemon.swift
//  Pokade
//
//  Created by Jona De Neve on 26/12/2022.
//

import Foundation
import Combine

class PokemonRequest: PARequest<PAPokemon>, Codable {
    private(set) var pokemon: String?

    static var all: [PAPokemon] {
        requests.values.compactMap({ $0.results.value.first }).sorted()
    }

    var info: PAPokemon? { results.value.first }

    private static var requests = [String:PokemonRequest]()
    private static var cancellables = [AnyCancellable]()

    @discardableResult
    static func fetch(_ pokemon: String, perform: ((PAPokemon) -> Void)? = nil) -> PAPokemon? {
        let request = Self.requests[pokemon]
        if request == nil {
            Self.requests[pokemon] = PokemonRequest(pokemon: pokemon)
            Self.requests[pokemon]?.fetch()
            return self.fetch(pokemon, perform: perform)
        } else if perform != nil {
            if let info = request!.info {
                perform!(info)
            } else {
                request!.results.sink { infos in
                    if let info = infos.first {
                        perform!(info)
                    }
                }.store(in: &Self.cancellables)
            }
        }
        return Self.requests[pokemon]?.results.value.first
    }

    private init(pokemon: String) {
        super.init()
        self.pokemon = pokemon
    }

    override var query: String {
        var request = "pokemon/"
        request.addPokeAPIArgument(pokemon)
        return request
    }

    override var cacheKey: String? { "\(type(of: self)).\(pokemon!)" }

    override func decode(_ data: Data) -> Set<PAPokemon> {
        var result = (try? JSONDecoder().decode(PokemonRequest.self, from: data))?.pAResult
        result?.test = pokemon
        return Set(result == nil ? [] : [result!])
    }

    private var pAResult: PAPokemon?

    private enum CodingKeys: String, CodingKey {
        case pAResult
    }
}

