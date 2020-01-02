//
//  TeamLead.swift
//  TeamLead
//
//  Created by Ufuk Türközü on 13.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class TeamLead {
    var image: UIImage
    var name: String
    var isLiked: Bool
    
    init(image: UIImage, name: String, isLiked: Bool = false) {
        self.name = name
        self.image = image
        self.isLiked = isLiked
    }
}
