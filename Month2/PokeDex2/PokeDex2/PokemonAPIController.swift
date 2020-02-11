//
//  PokemonAPIController.swift
//  PokeDex2
//
//  Created by Ufuk Türközü on 19.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badRequest
    case noDecode
    case otherError
    case noURL
    case badData
}

class PokemonAPIController {
    
    var pokeList: [Pokemon] = []
    var pokemon: Pokemon?

    var baseURL = "https://pokeapi.co/docs/v2/"
    
    func seachPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let searchURL = URL(string: baseURL)!.appendingPathComponent("pokemon/\(searchTerm)")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.otherError))
                print(error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Response code \(response.statusCode)")
                print("error response: \(error)")
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonResult
                self.pokeList.append(pokemonResult)
                completion(.success(pokemonResult))
            } catch {
                print("Error decodig: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
//    func fetchPokeImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
//            
//        let imageUrl = URL(string: urlString)!
//            
//        let request = URLRequest(url: imageUrl)
//            
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let _ = error {
//            completion(.failure(.otherError))
//            return
//            }
//                
//            guard let data = data else {
//                completion( .failure(.badData))
//                return
//            }
//                
//                let image = UIImage(data: data)!
//                completion(.success(image))
//        }.resume()
//    }
}

