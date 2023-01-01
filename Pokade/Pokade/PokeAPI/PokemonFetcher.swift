//
//  Test.swift
//  Pokade
//
//  Created by Jona De Neve on 31/12/2022.
//

import Foundation

struct PokemonFetcher {
    func getPokemon(id: String, completion: @escaping (Result<PAPokemon, Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(PAPokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


