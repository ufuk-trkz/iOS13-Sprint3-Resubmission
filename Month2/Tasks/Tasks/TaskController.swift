//
//  TaskController.swift
//  Tasks
//
//  Created by Ufuk Türközü on 27.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
    case put = "PUT"
    case delete = "DELETE"
}

class TaskController {
    
    // We are using this as the "viewDidLoad" of the TaskController
    init() {
        fetchTasksFromServer()
    }
    
    let baseURL = URL(string: "https://tasks-3f211.firebaseio.com/")!
    
    func put(task: Task, completion: @escaping () -> Void = { }) {
        let identifier = task.identifier ?? UUID()
        task.identifier = identifier
        
        let requestURL = baseURL.appendingPathComponent(identifier.uuidString).appendingPathExtension("json")
    
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        
        guard let taskRepresentation = task.taskRepresentation else {
            NSLog("Task Representation is nil")
            completion()
            return
        }
        
        do {
            request.httpBody = try JSONEncoder().encode(taskRepresentation)
        } catch {
            NSLog("Error encoding task representation: \(error)")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error PUTting task to server: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
    
    func fetchTasksFromServer(completion: @escaping() -> Void = { }) {
        // appendingPathComponent adds a "/"
        // appendingPathExtension add a "."
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { data, _, error in
            
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let taskRepresentations = try decoder.decode([String: TaskRepresentation].self, from: data).map({ $0.value })
                self.updateTasks(with: taskRepresentations)
                DispatchQueue.main.async {
                    completion()
                }
                
            } catch {
                NSLog("Error decoding task representations: \(error)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
    }
       
    func deleteEntryFromServer(task: Task, completion: @escaping (Error?) -> Void = { _ in }) {
        
    
        guard let uuid = task.identifier else {
            completion(NSError())
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            print(response!)
            DispatchQueue.main.async {
                completion(error)
            }
        }.resume()
    }
    
    private func updateTasks(with representations: [TaskRepresentation]) {
        let identifiersToFetch = representations.compactMap({ UUID(uuidString: $0.identifier)})
        
        // [UUID: TaskRepresentation]
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        // Make a mutable copy of the dictionary above
        var tasksToCreate = representationsByID
        
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
        
        do {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
            
            // Which of these tasks exist in Core Data already?
            let existingTasks = try context.fetch(fetchRequest)
            
            // Which need to be updated? Which need to be put into Core Data?
            for task in existingTasks {
                guard let identifier = task.identifier,
                    // This gets the task representation that corresponds to the task from CoreData
                    let representation = representationsByID[identifier] else { continue }
                
                task.name = representation.name
                task.notes = representation.notes
                task.priority = representation.priority
                
                tasksToCreate.removeValue(forKey: identifier)
            }
            // Take the tasks that AREN'T in Core Data and create new ones for them.
            for representation in tasksToCreate.values {
                Task(taskRepresentation: representation, context: context)
            }
            
            CoreDataStack.shared.save(context: context)
            
        } catch {
            NSLog("Error fetching tasks from persistent store: \(error)")
        }
        
    }
    }
    
    @discardableResult func createTask(with name: String, notes: String, priority: TaskPriority) -> Task {
        
        let task = Task(name: name,
                        notes: notes,
                        priority: priority,
                        context: CoreDataStack.shared.mainContext)
        
        CoreDataStack.shared.save()
        put(task: task)
        
        return task
    }
    
    func updateTask(task: Task, with name: String, notes: String?, priority: TaskPriority) {
        
        task.name = name
        task.notes = notes
        task.priority = priority.rawValue
        
        put(task: task)
        CoreDataStack.shared.save()
    }
    
    func delete(task: Task) {
        deleteEntryFromServer(task: task) { error in
            
        }
        CoreDataStack.shared.mainContext.delete(task)
        CoreDataStack.shared.save()
    }
}
