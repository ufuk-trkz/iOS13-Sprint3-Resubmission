//
//  Pokemon.swift
//  PokeDex
//
//  Created by Ufuk Türközü on 17.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    var name: String?
    var id: Int?
    var abilities: [PokeAbility]
    var types: [PokeType]
    var sprites: Sprite?
    
    struct PokeAbility: Decodable {
        var ability: AbilityName
    }

    struct AbilityName: Decodable {
        var name: String
    }
    
    struct PokeType: Decodable {
        var type: TypeName
    }

    struct TypeName: Decodable {
        var name: String
    }
    
    struct Sprite: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        var frontDefault: String
    }
    
}


