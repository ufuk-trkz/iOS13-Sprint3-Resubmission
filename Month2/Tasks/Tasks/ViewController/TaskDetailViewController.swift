//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Ufuk Türközü on 27.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var notesTV: UITextView!
    @IBOutlet weak var prioritySC: UISegmentedControl!
    
    // MARK: - Properties
    var taskController: TaskController?
    var task: Task?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func save(_ sender: Any) {
        
        guard let name = nameTF.text, let notes = notesTV.text,
            !name.isEmpty else { return }
        
        // Using some information from the segmented control, get a TaskPriority to pass to the fnctions below.
        
//        let priority = TaskPriority(rawValue: prioritySC.selectedSegmentIndex.description)
        
        let index = prioritySC.selectedSegmentIndex
        
        let priority = TaskPriority.allCases[index]
        
        if let task = task {
            taskController?.updateTask(task: task, with: name, notes: notes, priority: priority)
        } else {
            taskController?.createTask(with: name, notes: notes, priority: priority)
        }
        
    }
    
/*  @objc private func saveTask() {
        guard let name = nameTF.text,
            !name.isEmpty else { return }
        
        let notes = noteTV.text
        let _ = Task(name: name, notes: notes)
     
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
        } catch {
            NSLog("Error saving managed object context. \(error)")
        }
    }
*/
    private func updateViews() {
        guard isViewLoaded else { return }
        
        title = task?.name ?? "Create Task"
        nameTF.text = task?.name
        notesTV.text = task?.notes
        
        if let taskPriority = task?.priority,
        let priority = TaskPriority(rawValue: taskPriority) {
            
            prioritySC.selectedSegmentIndex = TaskPriority.allCases.firstIndex(of: priority) ?? 1
        }
    }
}
