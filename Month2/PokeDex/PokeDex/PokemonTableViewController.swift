//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Ufuk Türközü on 17.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let apiController = APIController()
    
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
        
        let pokemon = apiController.pokeList[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = pokemon.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
        if editingStyle == .delete {
        self.apiController.pokeList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchViewSegue" {
            guard let directionVC = segue.destination as? DetailViewController else { return }
            directionVC.apiController = apiController
        } else if segue.identifier == "PokemonDetailSegue" {
            guard let DetailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
                DetailVC.apiController = apiController
                DetailVC.pokemon = apiController.pokeList[indexPath.row]
        }
    }
}
