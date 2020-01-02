//
//  FriendsTableViewController.swift
//  HobbyTracker
//
//  Created by Ufuk Türközü on 12.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class FriendsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var friends: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // What information should be in each cell?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else { fatalError("This is not a FreindTableViewCell") }
        
        let friend = friends[indexPath.row]
        
        // This would trigger the didSet, so we don't need to call.updateViews() afterwards
        cell.friend = friend
    
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "AddFriendModal" {
                if let addFriendVC = segue.destination as? AddFriendViewController {
            // Hey I'm (the tble view controller) going to be the person you tell when a new friend is created
            // Sets up the TVC as
                        addFriendVC.delegate = self
                    }
            } else if segue.identifier == "ShowFriendDetail" {
                // We know that we are segueing to the FriendDetailViewController
                
                // What friend do we need to pass over?
                guard let friendDetailVC = segue.destination as? FriendDetailViewController else { return }
                    
                if let indexPath = tableView.indexPathForSelectedRow {
                    let friend = friends[indexPath.row]
                    
                    // This will call the updateViews because of the didSet
                    friendDetailVC.friend = friend
            }
        }
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


extension FriendsTableViewController: AddFreindDelegate {
    
    func friendWasCreated(friend: Person) {
        friends.append(friend)
        
        tableView.reloadData()
    }
        
}

