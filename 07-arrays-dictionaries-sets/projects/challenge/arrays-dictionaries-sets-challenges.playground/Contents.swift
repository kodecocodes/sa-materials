/**
 * Copyright (c) 2021 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
/*:
 ## Arrays
 ### Challenge 1: Which is valid
 Which of the following are valid statements?
*/
 
let array1 = [Int]() // Valid
//let array2 = [] // Invalid: the type cannot be inferred
let array3: [String] = [] // Valid

//: Given:
let array4 = [1, 2, 3]

//: Which of the following five statements are valid

print(array4[0]) // Valid
//print(array4[5]) // Will compile, but will cause an error at runtime: index out of bounds
array4[1...2] // Valid
//array4[0] = 4 // Invalid: a constant array cannot be modified
//array4.append(4) // Invalid: a constant array cannot be modified

//: Given:
var array5 = [1, 2, 3]

//: Which of the five statements are valid?

array5[0] = array5[1]  // Valid
array5[0...1] = [4, 5] // Valid
//array5[0] = "Six" // Invalid: an element of type String cannot be added to an array of type [Int]
//array5 += 6 // Invalid: the += operator requires an array on the right-hand side, not a single element
for item in array5 { print(item) }  // Valid

/*:
 ### Challenge 2: Remove the first number
 Write a function that removes the first occurrence of a given integer from an array of integers.
 This is the signature of the function:
 
 ```
 func removingOnce(_ item: Int, from array: [Int]) -> [Int]
 ```
*/

func removingOnce(_ item: Int, from array: [Int]) -> [Int] {
  var result = array
  if let index = array.firstIndex(of: item) {
    result.remove(at: index)
  }
  return result
}

/*:
 ### Challenge 3: Remove the numbers
 Write a function that removes all occurrences of a given integer from an array of integers. 
 This is the signature of the function:
 
```
 func removing(_ item: Int, from array: [Int]) -> [Int]
```
*/

func removing(_ item: Int, from array: [Int]) -> [Int] {
  var newArray: [Int] = []
  for candidateItem in array {
    if candidateItem != item {
      newArray.append(candidateItem)
    }
  }
  return newArray
}

/*:
 ### Challenge 4: Reverse an array
 Arrays have a `reversed()` method that returns an array holding the same elements as the original array, in reverse order. 
 Write a function that does the same thing, without using `reversed()`. This is the signature of the function:

 ```
 func reversed(_ array: [Int]) -> [Int]
 ```
*/

func reversed(_ array: [Int]) -> [Int] {
  var newArray: [Int] = []
  for item in array {
    newArray.insert(item, at: 0)
  }
  return newArray
}

/*:
 ### Challenge 5: Return the middle
 Write a function that returns the middle element of an array.
 When array size is even, return the first of the two middle elements.
 
 ```swift
 func middle(_ array: [Int]) -> Int?
 ```
*/

func middle(_ array: [Int]) -> Int? {
  guard !array.isEmpty else {
    return nil
  }
  return array[(array.count-1)/2]
}

/*:
 ### Challenge 6: Find the minimum and maximum
 
 Write a function that calculates the minimum and maximum value in an array of integers. 
 Calculate these values yourself, do not use the methods `min` and `max`. 
 Return `nil` if the given array is empty.
 
 This is the signature of the function:

```
func minMax(of numbers: [Int]) -> (min: Int, max: Int)?
```
 
 */
func minMax(of numbers: [Int]) -> (min: Int, max: Int)? {
  if numbers.isEmpty {
    return nil
  }

  var min = numbers[0]
  var max = numbers[0]
  for number in numbers {
    if number < min {
      min = number
    }
    if number > max {
      max = number
    }
  }
  return (min, max)
}

/*:
 ## Dictionaries
 ### Challenge 7: Which is valid
 Which of the following statements are valid?
 */

//let dict1: [Int, Int] = [:] // Invalid: type should be [Int: Int] not [Int, Int]
//let dict2 = [:] // Invalid: type cannot be inferred
let dict3: [Int: Int] = [:] // Valid

//: Given
let dict4 = ["One": 1, "Two": 2, "Three": 3]
//: Which of the following are valid:

//dict4[1] // Invalid: key should be String, not Int
dict4["One"] // Valid
//dict4["Zero"] = 0 // Invalid: dict4 is a constant
//dict4[0] = "Zero" // Invalid: key should be a String and value should be an Int - and dict4 is a constant anyway

//: Given
var dict5 = ["NY": "New York", "CA": "California"]

//: Which of the following are valid?
dict5["NY"]  // Valid
dict5["WA"] = "Washington" // Valid
dict5["CA"] = nil // Valid


/*:
 ### Challenge 8: Long names
 Given a dictionary with 2-letter state codes as keys and the full state name as values, write a function that prints all the states whose name is longer than 8 characters. For example, for this dictionary ["NY": "New York", "CA": "California"] the output would be "California".
 */

func printLongStateNames(in dictionary: [String: String]) {
  for (_, value) in dictionary {
    if value.count > 8 {
      print(value)
    }
  }
}

/*:
 ### Challenge 9: Merge dictionaries
 Write a function that combines two dictionaries into one. If a certain key appears in both dictionaries, ignore the pair from the first dictionary.
 This is the signature of the function:
 ```
 func combine(dict1: [String: String], with dict2: [String: String]) -> [String: String]
 ```
 */

func merging(_ dict1: [String: String], with dict2: [String: String]) -> [String: String] {
  var newDictionary = dict1
  for (key, value) in dict2 {
    newDictionary[key] = value
  }
  return newDictionary
}

/*:
 ### Challenge 10: Count the characters
 Declare a function `occurrencesOfCharacters` that calculates which characters occur in a string, as well as how often each of these characters occur.
 Return the result as a dictionary. This is the function signature:
 ```
 func occurrencesOfCharacters(in text: String) -> [Character: Int]
 ```
 Hint: `String` is a collection of characters that you can iterate over with a for statement.
*/

func occurrencesOfCharacters(in text: String) -> [Character: Int] {
  var occurrences: [Character: Int] = [:]
  for character in text {
    if let count = occurrences[character] {
      occurrences[character] = count + 1
    } else {
      occurrences[character] = 1
    }
  }
  return occurrences
}

/*
 Bonus: To make your code shorter, dictionaries have a special subscript operator that let you add a default value if it is not found in the dictionary. For example, dictionary["a", default: 0] creates a 0 entry for the character "a" if it is not found instead of returning nil.
*/

func occurrencesOfCharactersBonus(in text: String) -> [Character: Int] {
  var occurrences: [Character: Int] = [:]
  for character in text {
    occurrences[character, default: 0] += 1
  }
  return occurrences
}

/*:
 ### Challenge 11: Unique values
 Write a function that returns true if all of the values of a dictionary are unique.  Use a set to test uniqueness.
 This is the function signature:
 ```
 func isInvertible(_ dictionary: [String: Int]) -> Bool
 ```
 */
func isInvertible(_ dictionary: [String: Int]) -> Bool {
  var seenValues: Set<Int> = []
  for value in dictionary.values {
    if seenValues.contains(value) {
      return false  // duplicate value detected
    }
    seenValues.insert(value)
  }
  return true
}

/*:
 ### Challenge 12: Removing keys and setting values to nil
 Given the dictionary:
 */
var nameTitleLookup: [String: String?] = ["Mary": "Engineer", "Patrick": "Intern", "Ray": "Hacker"]


nameTitleLookup.updateValue(nil, forKey: "Patrick")
nameTitleLookup["Ray"] = nil  // or nameTitleLookup.removeValue(forKey: "Ray")

