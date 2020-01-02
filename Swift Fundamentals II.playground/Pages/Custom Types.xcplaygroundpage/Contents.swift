import UIKit

// Custom Types

// Define custom types using: class, struct, enum

// A representation of some real world information. E.g. a person has a name, age, etc. as related values

// Allows us to combine related properties, chunks of code, etc.

// camelCase - aLongSentence instead a long sentence

// UpperCamelCase - ALongSentence

// There is a type called "Coffee" who has a property called "name".

// Custom datatypes (like Coffee) are capitalized

// Struct

struct Coffee {
    
    let name: String
    let region: String
    let roastLevel: RoastLevel // enum
    
}

// We have "defined" the "Coffee" strcut. This is the "idea" or "blueprint" of coffee

// Enums are great for purposely limiting our options:

enum RoastLevel: String {
    case light = "Light"
    case medium = "Medium"
    case dark = "Dark"
}

let myFavoriteRoastLevel: RoastLevel = .dark

// Create an instance of Coffee. This is the physical cup of coffee:

let MyCoffee = Coffee(name: "Folgers", region: "Colombia", roastLevel: .medium)
let JamesCoffee = Coffee(name: "Pike's Place", region: "Seattle", roastLevel: RoastLevel.light)

// Classes do not get an initalizer made for free

class CoffeeShop {
    // make this all variables
    // name
    // We don't give these values
    
    let name: String
    let city: String
    var coffees: [Coffee]
    
    init(name: String, city: String, coffees: [Coffee]) {
        self.name = name
        self.city = city
        self.coffees = coffees
    }
}

let myShop = CoffeeShop(name: "Ufuk's Coffee", city: "Duisburg", coffees: [])

let troysLevel = RoastLevel.medium

// Later on, I ask Chad what his favorite coffee is

print("My favorite coffee is \(JamesCoffee.name)")

JamesCoffee.region


