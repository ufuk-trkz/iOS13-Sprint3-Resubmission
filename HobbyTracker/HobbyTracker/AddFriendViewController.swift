//
//  AddFriendViewController.swift
//  HobbyTracker
//
//  Created by Ufuk Türközü on 12.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

protocol AddFreindDelegate {
    
    func friendWasCreated(friend: Person)
}

class AddFriendViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var hobbyOneTextField: UITextField!
    @IBOutlet weak var hobbyTwoTextField: UITextField!
    @IBOutlet weak var hobbyThreeTextField: UITextField!
    
    var delegate: AddFreindDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        hometownTextField.delegate = self
        hobbyOneTextField.delegate = self
        hobbyTwoTextField.delegate = self
        hobbyThreeTextField.delegate = self
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let hometown = hometownTextField.text,
            !name.isEmpty, !hometown.isEmpty else { return }
        
        var newFriend = Person(name: name, homeTown: hometown, hobbies: [])
        
        if let hobby1 = hobbyOneTextField.text, !hobby1.isEmpty {
            newFriend.hobbies.append(hobby1)
        }

        if let hobby2 = hobbyTwoTextField.text, !hobby2.isEmpty {
            newFriend.hobbies.append(hobby2)
        }
        
        if let hobby3 = hobbyThreeTextField.text, !hobby3.isEmpty {
            newFriend.hobbies.append(hobby3)
        }
        
        // Tell the delegate that our friend was created
        
        delegate?.friendWasCreated(friend: newFriend)
        dismiss(animated: true, completion: nil)
    }
}
    
extension AddFriendViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



