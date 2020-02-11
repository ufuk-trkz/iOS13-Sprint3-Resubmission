//
//  PokemonTableViewController.swift
//  PokeDex2
//
//  Created by Ufuk Türközü on 19.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let apiController = PokemonAPIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokeList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)

        // Configure the cell...
        if let pokemon = apiController.pokemon {
        cell.textLabel?.text = pokemon.name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
        if editingStyle == .delete {
        self.apiController.pokeList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }

}
