//
//  TasksTableViewController.swift
//  Tasks
//
//  Created by Ufuk Türközü on 27.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    // MARK: - Properties
    var task: Task?
    
    let taskController = TaskController()
    
// NOTE! - This is not a good, efficient wy to do this, as the fetch request will be executed everytime tasks property is accessed. We will learn a better way to do this later.
        
//    var tasks: [Task] {
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        let context = CoreDataStack.shared.mainContext
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            NSLog("Error fetching tasks: \(error)")
//            return []
//        }
//    }
    
    lazy var fetchResultsController: NSFetchedResultsController<Task> = {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "priority", ascending: true)]
        // You must make the decriptor with the same key path as the sectionNameKeyPath be the first sort descriptors in this array
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "priority",
                                             cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        
        return frc
    }()

    // MARK: - View Lifeycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        // Configure the cell...
        let task = fetchResultsController.object(at: indexPath)
        cell.textLabel?.text = task.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = fetchResultsController.sections?[section] else { return nil }
        
        return sectionInfo.name.capitalized
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = fetchResultsController.object(at: indexPath)
            // Delete the row from the data source
            taskController.delete(task: task)
            CoreDataStack.shared.mainContext.delete(task)
            CoreDataStack.shared.save()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            guard let detailVC = segue.destination as? TaskDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {
                    return }
            
            detailVC.task = fetchResultsController.object(at: indexPath)
            detailVC.taskController = self.taskController
            
        } else if segue.identifier == "AddTaskSegue" {
            guard let detailVC = segue.destination as? TaskDetailViewController else { return }
            detailVC.taskController = self.taskController
        }
    }
}

extension TasksTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .insert:
                guard let newIndexPath = newIndexPath else { return }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .delete:
                guard let indexPath = indexPath else { return }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            case .move:
                guard let newIndexPath = newIndexPath, let indexPath = indexPath else { return }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { return }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let sectionSet = IndexSet(integer: sectionIndex)
        
        switch type {
            case .insert:
                tableView.insertSections(sectionSet, with: .automatic)
            case .delete:
                tableView.deleteSections(sectionSet, with: .automatic)
            default:
                return
        }
    }
}
