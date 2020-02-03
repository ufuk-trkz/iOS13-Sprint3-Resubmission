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
    
    let apiController = APIController()
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
        
        apiController.fetchImage(at: pokemon.sprite.default) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemonIV.image = image
                }
            }
        }
    }
    
    func updateViews() {
        nameLabel.text = pokemon?.name
        idLabel.text = String(describing: pokemon?.id)
        
    }
    
    @IBOutlet weak var search: UISearchBar!
    
    @IBAction func saveTapped(_ sender: Any) {
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
        guard let searchTerm = searchBar.text else { return }
       
        apiController.searchPokemon(searchTerm: searchTerm) { result in
            let pokemon = try? result.get()
                            
            DispatchQueue.main.async {
                self.pokemon = pokemon

            }
        }
    }
}

