//
//  ShoppingItemCollectionViewCell.swift
//  Shopping List
//
//  Created by Ufuk Türközü on 02.01.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ShoppingItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let item = shoppingItem {
            itemImageView.image = UIImage(named: item.itemName)
            itemNameLabel.text = item.itemName
            
            if item.hasBeenAdded {
                stateLabel.text = "Added"
            } else {
                stateLabel.text = "Not Added"
            }
        }
    }
}
