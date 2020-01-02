/*
Challenge
"A, E, I, O, U, and sometimes Y..."

Write a function called numberOfVowels(in string: String) that returns the count of the total number of vowels in a string. Your solution should be case-insensitive, and allow for 'Y' to be included, or excluded from the count when calling the function.

Example: numberOfVowels(in: "Polly wants a cracker!", isYAVowel = true) // returns 6


*/

import UIKit

func numberOfVowels(in string: String, isYAVowel: Bool = false) -> Int {
    
    var count: Int = 0
    
    if isYAVowel == true {
    
        for character in string.lowercased() {
            switch character {
            case "a", "e", "i", "o", "u", "y":
                count += 1
            default: continue
            }
        }
    } else {
        
        for character in string.lowercased() {
            switch character {
            case "a", "e", "i", "o", "u":
                count += 1
            default: continue
            }
        }
    }
    print(count)
    return count
}

numberOfVowels(in: "Polly wants a cracker!", isYAVowel: true)
numberOfVowels(in: "POlly wants a cracker!", isYAVowel: false)
numberOfVowels(in: "POlly wants a cracker!", isYAVowel: true)
