//
//  ViewController.swift
//  ColorPicker
//
//  Created by Ufuk Türközü on 23.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeColor(_ sender: ColorPicker) {
        view.backgroundColor = sender.color
    }


}

