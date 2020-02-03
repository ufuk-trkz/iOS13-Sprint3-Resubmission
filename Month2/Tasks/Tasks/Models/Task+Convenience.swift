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

// static var allPriorities: [TaskPriority] {
//      return = [.low, .normal, .high, .critical]
// }
}
// Core Data already created the Task class, so we just want to add some extra functionality 
extension Task {
    
    var taskRepresentation: TaskRepresentation? {
        guard let name = name, let priority = priority, let identifier = identifier?.uuidString else { return nil }
        
        return TaskRepresentation(name: name, notes: notes, identifier: identifier, prioriry: priority)
    }
    
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
    
    @discardableResult convenience init?(taskRepresentation: TaskRepresentation, context: NSManagedObjectContext) {
        
        guard let identifier = UUID(uuidString: taskRepresentation.identifier), let priority = TaskPriority(rawValue: taskRepresentation.prioriry) else { return nil }
        
        self.init(name: taskRepresentation.name,
                  notes: taskRepresentation.notes,
                  priority: priority,
                  identifier: identifier,
                  context: context)
    }
}
