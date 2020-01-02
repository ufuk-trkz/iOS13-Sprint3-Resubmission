//
//  FriendDetailViewController.swift
//  HobbyTracker
//
//  Created by Spencer Curtis on 11/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var hobbiesTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var friend: Person? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
        // Make sure the view controller had enoughh time to set up the outlets
        guard isViewLoaded else { return }
        
        guard let friend = friend else { return }
        
        nameLabel.text = friend.name
        hometownLabel.text = friend.homeTown
        
        var hobbyText = ""
        
        // this is the string that we will give 
        for hobby in friend.hobbies {
            hobbyText += "• \(hobby)\n"
        }
        hobbiesTextView.text = hobbyText
    }
}
