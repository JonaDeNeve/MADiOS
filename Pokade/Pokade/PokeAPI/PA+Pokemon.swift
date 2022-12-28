//
//  PA+Pokemon.swift
//  Pokade
//
//  Created by Jona De Neve on 26/12/2022.
//

import Foundation
import Combine

class PokemonRequest: PARequest<PAPokemon>, Codable
{
    private(set) var pokemon: String!
    
    private static var requests = [String:PokemonRequest]()
    
    static func create(pokemon: String, howMany: Int? = nil) -> PokemonRequest {
        if let request = requests[pokemon] {
            request.howMany = howMany ?? request.howMany
            return request
        } else {
            let request = PokemonRequest(pokemon: pokemon, howMany: howMany)
            requests[pokemon] = request
            return request
        }
    }
    
    private init(pokemon: String, howMany: Int? = nil) {
        super.init()
        self.pokemon = pokemon
        if howMany != nil { self.howMany = howMany! }
    }
    
    private static var sharedFetchTimer: Timer?
    
    override var fetchTimer: Timer? {
        get { Self.sharedFetchTimer }
        set {
            Self.sharedFetchTimer?.invalidate()
            Self.sharedFetchTimer = newValue
        }
    }

    override var cacheKey: String? { "\(type(of: self)).\(pokemon!)" }
    
    override func decode(_ data: Data) -> Set<PAPokemon> {
        let result = (try? JSONDecoder().decode(PokemonRequest.self, from: data))?.PAResult
        offset = result?.next_offset ?? 0
        return Set(result?.pokemon ?? [])
    }
    
    override var query: String {
        var request = "pokemon/"
        request.addPokeAPIArgument(pokemon)
        return request
    }
    
    private var PAResult: PokemonResult?
    
    private enum CodingKeys: String, CodingKey {
        case PAResult = "PokemonResult"
    }
    
    private struct PokemonResult: Codable {
        var next_offset: Int
        var pokemon: [PAPokemon]
    }
}
