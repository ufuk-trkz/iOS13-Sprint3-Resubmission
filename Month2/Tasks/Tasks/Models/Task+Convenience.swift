//
//  Task+Convenience.swift
//  Tasks
//
//  Created by Ufuk Türközü on 27.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import CoreData

enum TaskPriority: String, CaseIterable {
    case low
    case normal
    case high
    case critical
}
// Core Data already created the Task class, so we just want to add some extra functionality 
extension Task {
    
    // This is to turn a Core Data Managed Task into a TaskRepresentation for marshaling to JSON and sending to the server.
    var taskRepresentation: TaskRepresentation? {
        guard let name = name, let priority = priority, let identifier = identifier?.uuidString else { return nil }
        
        return TaskRepresentation(identifier: identifier, name: name, notes: notes, priority: priority)
    }
    // This is for creating a new managed object in Core Data
    convenience init(name: String,
                     notes: String?,
                     priority: TaskPriority/* = .normal */,
                     identifier: UUID = UUID(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        // Setting up the generic NSManagedObjectContext functionality of the model object
        // The generic chuk of clay:
        self.init(context: context)
        // Once we have the clay, we can begin sculpting it into our unique model onject
        self.name = name
        self.notes = notes
        self.priority = priority.rawValue
        self.identifier = identifier
    }
    // This is for converting TaskRepresentation (comes from JSON) into a Managed Object for Core Data.
    @discardableResult convenience init?(taskRepresentation: TaskRepresentation, context: NSManagedObjectContext) {
        
        guard let identifier = UUID(uuidString: taskRepresentation.identifier), let priority = TaskPriority(rawValue: taskRepresentation.priority) else { return nil }
        
        self.init(name: taskRepresentation.name,
                  notes: taskRepresentation.notes,
                  priority: priority,
                  identifier: identifier,
                  context: context)
    }
}
