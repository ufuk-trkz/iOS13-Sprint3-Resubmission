//
//  Plant+Conveniene.swift
//  WaterMyPlants
//
//  Created by Ufuk Türközü on 03.02.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    
    var plantRepresentation: PlantRepresentation? {
        guard let title = title, let identifier = identifier else { return nil }
        return PlantRepresentation(title: title, identifier: identifier, hasWatched: hasWatched)
    }
    
    convenience init(title: String,
                     identifier: UUID = UUID(),
                     hasWatched: Bool,
                     context: NSManagedObjectContext = CoreDataStack.share.mainContext) {
        
        self.init(context: context)
        self. = title
        self.id = id
        self.nickname = nickname
    }
    
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation, context: NSManagedObjectContext) {
        
        self.init(title: movieRepresentation.title,
                  id: plantRepresentation.id ?? UUID(),
                  hasWatched: plantRepresentation.hasWatched ?? false,
                  context: context)
    
    }
    
}
