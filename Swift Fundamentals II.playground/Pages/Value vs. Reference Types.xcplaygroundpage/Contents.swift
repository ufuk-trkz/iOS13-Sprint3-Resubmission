//: [Previous](@previous)

import Foundation

// Structs are value types
// Classes are refrence types

class Ticket {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var myTicket = Ticket(name: "Ufuk")

print(myTicket.name)

myTicket.name = "Bob"

print(myTicket.name)

var ticketCopy = myTicket

ticketCopy.name = "Sue"

print(myTicket.name)

//func changeTicketName(ticket: Ticket) {
//    let updatedTicket = ticket
//    updatedTicket.name = "John"
//    print("Updated ticket name to \(updatedTicket.name)")
//
//}

class City {
    var name: String
    var population: Int
    
    init(name: String, population: Int) {
        self.name = name
        self.population = population
    }
}

var orlando = City(name: "Orlando", population: 280_257)

func increasePopulationOfCity(city: City) {
    city.population += 1
    print(city.population)
}

print(orlando.population)
increasePopulationOfCity(city: orlando)
print(orlando.population)


