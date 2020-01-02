//
//  RedViewController.swift
//  Screens
//
//  Created by Ufuk Türközü on 16.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class RedViewController: NumberedViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToRed(_ sender: UIStoryboardSegue) {
        
        
    }
    
    /*
    
 - Create the unwind action in the view controller you want to go back to. Create it either through the autocomplete shortcut, or by making an action from the button (and changing the type from Any to UIStoryboardSegue). For example:
 @IBAction func unwindToRed(_ sender: UIStoryboardSegue) {
 }
 
 - In the storyboard, control + drag from the button to the exit icon at the top of the view controller and select your unwind segue.
 
    
    
    
    */
}
