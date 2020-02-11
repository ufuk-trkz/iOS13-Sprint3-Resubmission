//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Ufuk Türközü on 17.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIV: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var apiController = APIController()

    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func getDetails() {
        guard let pokemon = pokemon else { return }
        
        apiController.fetchImage(at: pokemon.sprites!.frontDefault) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
    
    func updateViews() {
        guard let pokemon = pokemon else { return }
        guard let imageData = try? Data(contentsOf: URL(string: pokemon.sprites!.frontDefault)!) else { return }
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

extension DetailViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
       
        apiController.searchPokemon(searchTerm: searchTerm) { result in
            let pokemon = try? result.get()
                            
            DispatchQueue.main.async {
                self.pokemon = pokemon

            }
        }
    }
}

