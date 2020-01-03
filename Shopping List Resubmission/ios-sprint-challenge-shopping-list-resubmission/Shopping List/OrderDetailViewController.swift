//
//  OrderDetailViewController.swift
//  Shopping List
//
//  Created by Ufuk Türközü on 02.01.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import UserNotifications

class OrderDetailViewController: UIViewController {
    
    var shoppingItemC: ShoppingItemController?
    
    @IBOutlet weak var currentItemsLabel: UILabel!
    @IBOutlet weak var enterNameTF: UITextField!
    @IBOutlet weak var enterAddressTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    
    @IBAction func sendOrderTapped(_ sender: Any) {
        alert()
    }
    
    func alert() {
        if let customerName = enterNameTF.text, let customerAddress = enterAddressTF.text {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
            
            let content = UNMutableNotificationContent()
            content.title = "Delivery for \(customerName)"
            content.subtitle = "Your shopping items will be delivered to \(customerAddress)"
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "Send Order", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    
    func updateViews() {
        if let shoppingList = shoppingItemC {
            let selectedItems = shoppingList.shoppingList.filter({$0.hasBeenAdded == true})
            currentItemsLabel.text = "You have \(selectedItems.count) item(s) in your shopping list"
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
    
}
