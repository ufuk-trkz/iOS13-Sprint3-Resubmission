//
//  PokemonDetailViewController.swift
//  PokeDex2
//
//  Created by Ufuk Türközü on 19.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIV: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiController = PokemonAPIController()
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    func updateViews() {
        guard let pokemon = pokemon else {
            searchBar.placeholder = "Search Pokemon by Name or ID"
            hideOutlets()
            return
        }
    
        guard let imageData = try? Data(contentsOf: pokemon.sprites!.frontDefault) else { return }
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(String(describing: pokemon.id!))"
        pokemonIV.image = UIImage(data: imageData)
           
            
        var abilities: [String] = []
        var types: [String] = []
            
        for newType in pokemon.types {
            types.append(newType.type.name)
        }

        for newAbility in pokemon.abilities {
            abilities.append(newAbility.ability.name)
        }
            
        typesLabel.text = "Type: \(types.last!)"
        abilitiesLabel.text = "Ability: \(abilities.last!)"
    }
    
    func hideOutlets() {
        nameLabel.isHidden = true
        pokemonIV.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let pokemon = pokemon {
        apiController.pokeList.append(pokemon)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}  

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
       
        apiController.seachPokemon(searchTerm: searchTerm) { result in
            let pokemon = try? result.get()
                            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
    }
}
