//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ufuk Türközü on 14.02.20.
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
    @IBOutlet weak var saveButton: UIButton!
    
    var apiController: APIController?
    
    var pokemon: Pokemon? {
        didSet{
            guard let pokemon = pokemon else { return }
            getDetails()
            show()
            title = pokemon.name?.capitalized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getDetails()
        if nameLabel.text == "Pokemon" {
            hide()
        }
        // Do any additional setup after loading the view.
    }
    
    func getDetails() {
        guard let pokemon = pokemon, let pokemonName = pokemon.name else { return }
        
        apiController?.fetchDetails(for: pokemonName) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: pokemon)
                }
                self.apiController?.fetchImage(at: pokemon.sprites!.frontDefault) { result in
                    if let image = try? result.get() {
                        DispatchQueue.main.async {
                            self.updateViews(with: pokemon)
                        }
                    }
                }
            }
        }
    }
    
    func updateViews(with pokemon: Pokemon) {
        show()
        guard let imageData = try? Data(contentsOf: URL(string: pokemon.sprites!.frontDefault)!) else { return }
        nameLabel.text = pokemon.name?.capitalized
        idLabel.text  = "ID: \(String(describing: pokemon.id!))"
        guard let image = UIImage(data: imageData) else { return }
        pokemonIV.image = image
        
        
        var abilities: [String] = []
        var types: [String] = []
        
        for newType in pokemon.types {
            types.append(newType.type.name.capitalized)
        }
        
        for newAbility in pokemon.abilities {
            abilities.append(newAbility.ability.name.capitalized)
        }
        
        typesLabel.text = "Type: \(types.last!)"
        abilitiesLabel.text = "Ability: \(abilities.last!)"
    }
    
    func hide() {
        nameLabel.isHidden = true
        pokemonIV.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        saveButton.isHidden = true
    }
    
    func show() {
        nameLabel?.isHidden = false
        pokemonIV?.isHidden = false
        idLabel?.isHidden = false
        typesLabel?.isHidden = false
        abilitiesLabel?.isHidden = false
        saveButton?.isHidden = false
    }
    
    @IBAction func save(_ sender: Any) {
        if let pokemon = pokemon {
            apiController?.pokeList.append(pokemon)
        }

    }
    
}

extension PokemonDetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        apiController?.searchPokemon(searchTerm: searchTerm) { result in
            let pokemon = try? result.get()
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
    }
}
