//
//  TaskRepresentation.swift
//  Tasks
//
//  Created by Ufuk Türközü on 29.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation

// The TaskRepresentation is an exact copy of the Task bject in the data model, without its Core Data aspects.
struct TaskRepresentation: Codable {
    var identifier: String
    var name: String
    var notes: String?
    var priority: String
}
