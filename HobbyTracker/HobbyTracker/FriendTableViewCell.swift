//
//  FriendTableViewCell.swift
//  HobbyTracker
//
//  Created by Ufuk Türközü on 12.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var homeTownLabel: UILabel!
    @IBOutlet weak var hobbyCountLabel: UILabel!
    
    var friend: Person? {
        // Property Observer - Calls the code in the {} whenever the value of friend is set
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        nameLabel.text = friend?.name
        homeTownLabel.text = friend?.homeTown
        hobbyCountLabel.text = " \(friend?.hobbies.count ?? 0) hobbies"
        
    }
}
