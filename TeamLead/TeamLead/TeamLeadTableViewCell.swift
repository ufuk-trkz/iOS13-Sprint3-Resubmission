//
//  TeamLeadTableViewCell.swift
//  TeamLead
//
//  Created by Ufuk Türközü on 13.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class TeamLeadTableViewCell: UITableViewCell {

    @IBOutlet weak var teamLeadImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var isLikedButton: UIButton!
    @IBAction func likeButtonTapped(_ sender: Any) {
        teamLead?.isLiked.toggle()
        updateViews()
    }
    
    
    func updateViews() {
        if let teamLead = teamLead {
            nameLabel.text = teamLead.name
            teamLeadImageView.image = teamLead.image
            if teamLead.isLiked == true {
                isLikedButton.setTitle("Liked", for: .normal)
            } else {
                isLikedButton.setTitle("Not Liked", for: .normal)
            }
        }
    }
    
    var teamLead: TeamLead? {
        didSet {
            updateViews()
        }
    }
}
