//: [Previous](@previous)

import Foundation

// A UITextField is the standard way people type text on iOS, and it returns the value as a String type, not a number. There's a chance someone could type an invalid number when attempting to calculate a tip. For these situations, a tip calculation may not be possible.

// Optionals - Something may or may not have a value. If doesn't have a value, we call that nil

let pageNumber = "Spencer"

// I need to convert the String to an Int:

let pageNumberInt = Int(pageNumber)



let subtotalString = "58.95"

let subtotal = Double(subtotalString)

// Optional binding - Allowing us to "open" the optional box and see if there is a value or not

if let unwrappedSubtotal = subtotal /* if let subtotal = Double(subtotalString)*/ {
    
    let tip = subtotal * 0.20
    let total = subtotal + tip
    print("The total is: \(total) with a \(tip) tip included.") // print(subtotal)
}   else {
    print("\(subtotalString) is not a valid number")
}

// guard-let

//guard let unwrappedSubtotal = subtotal else {
//    print("\(subtotalString) is not a valid ")
//}


// Optionals: Don't always have to have a value. (nil)

struct Person {
    let firstName: String
    let lastName: String
    let middleName: String?
    
    // Method - It is directly implemented in the struct Person
    func printMiddleNameOf(person: Person) {
        print("My middle name is \(person.middleName)")
    }
}

// Force unwrapping

// I am 15 and I don't have a car:
var myCar: String? = nil

// I am 18 and I get a car
myCar = "Honda Civic"

if let unwrappedCar = myCar {
    print("My car is \(myCar)")
}




let bob = Person(firstName: "Bob", lastName: "James", middleName: "Joe")
let sue = Person(firstName: "Sue", lastName: "Miles", middleName: nil)

func printMiddleNameOf(person: Person) {
    print("My middle name is \(person.middleName)")
}
printMiddleNameOf(person: bob)

if let middleName = sue.middleName {
    print(middleName)
}

// Method vs. Function


//: [Next](@next)
