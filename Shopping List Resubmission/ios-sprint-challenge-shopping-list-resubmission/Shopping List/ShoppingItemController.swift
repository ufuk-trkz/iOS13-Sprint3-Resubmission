//
//  ShoppingItemController.swift
//  Shopping List
//
//  Created by Ufuk Türközü on 02.01.20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class ShoppingItemController {
    
    let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
    
    var shoppingList: [ShoppingItem] = []
    
    func createItem() {
            for item in itemNames {
               let shoppingItem = ShoppingItem(itemName: item, hasBeenAdded: false)
                shoppingList.append(shoppingItem)
            }
        }
    
    init() {
        let hasBeenAdded = UserDefaults.standard.bool(forKey: .hasBeenAddedKey)
        if hasBeenAdded {
            loadFromPersistentStore()
        } else {
            UserDefaults.standard.set(true, forKey: .hasBeenAddedKey)
            createItem()
            saveToPersistentStore()
        }
    }
    
    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let itemsURL = documentDir.appendingPathComponent("shoppingItems.plist")
        
        return itemsURL
    }
    
    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let itemsData = try encoder.encode(shoppingList)
            
            try itemsData.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let itemsData = try Data(contentsOf: fileURL)
            
            let decoder = PropertyListDecoder()
            let itemsArray = try decoder.decode([ShoppingItem].self, from: itemsData)
            self.shoppingList = itemsArray
        } catch {
            print(error)
        }
    }
}

extension String {
    static var hasBeenAddedKey = "hasBeenAdded"
}
