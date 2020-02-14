//
//  APIController.swift
//  Pokedex
//
//  Created by Ufuk Türközü on 14.02.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case badData
    case badRequest
    case otherError
    case noURL
    case noDecode
}

class APIController {
    
    var pokeList: [Pokemon] = []
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    func searchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let searchURL = baseURL?.appendingPathComponent("pokemon/\(searchTerm)") else {
            NSLog("No search URL")
            completion(.failure(.noURL))
            return
        }
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                NSLog("Error getting users\(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode !=  200 {
                print(response.statusCode)
                NSLog("request URL is nil")
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonResult = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonResult
                completion(.success(pokemonResult))
            } catch {
                print("error decodig: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchDetails(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let pokemonURL = baseURL?.appendingPathComponent("pokemon/\(pokemonName)") else { return }
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badRequest))
                return
            }
            
            if let error = error {
                print("Error receiving animal names: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding animal names details: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
        
        let imageUrl = URL(string: urlString)!
        
        let request = URLRequest(url: imageUrl)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion( .failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
}
