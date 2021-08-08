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

import Foundation

/*:
 ## Strings
 */

/*:
 ### Challenge 1: Character count
 Write a function that takes a string and prints out the count of each character in the string.
 
 For bonus points, print them ordered by the count of each character.
 
 For bonus-bonus points, print it as a nice histogram.
 
 Hint: You could use # characters to draw the bars.
 */

func printCharacterCount(for string: String) {
  guard string.count > 0 else { return }

  var counts: [Character: Int] = [:]

  for i in string {
    counts[i, default: 0] += 1
  }

  let sortedKeys = counts.keys.sorted { counts[$0]! > counts[$1]! }

  let max = counts[sortedKeys.first!]!

  for key in sortedKeys {
    let value = counts[key]!
    let widthOfHashes = (value * 20) / max
    let hashes = String(repeating: "#", count: widthOfHashes)
    print("\(key) : \(hashes) \(value)")
  }
}

printCharacterCount(for: "The quick brown fox jumps over the lazy dog")


/*:
 ### Challenge 2: Word count
 Write a function that tells you how many words there are in a string. Do it without splitting the string.
 
 Hint: try iterating through the string yourself.
 */

func numberOfWords(in sentence: String) -> Int {
  var count = 0
  var inWord = false

  for character in sentence {
    if character == " " {
      if inWord {
        count += 1
      }
      inWord = false
    } else {
      inWord = true
    }
  }

  // We need to add 1 to count the final word if there was at least 1 character
  if inWord {
    count += 1
  }

  return count
}

let wordCount = numberOfWords(in: "The quick brown fox jumps over the lazy dog")
print(wordCount)


/*:
 ### Challenge 3: Name formatter
Write a function that takes a string which looks like "Galloway, Matt" and returns one which looks like "Matt Galloway", i.e., the string goes from `"<LAST_NAME>, <FIRST_NAME>"` to `"<FIRST_NAME> <LAST_NAME>"`.
 */

func sanitized(name: String) -> String? {
  guard let indexOfComma = name.firstIndex(of: ",") else {
    return nil
  }

  let lastNameSubstring = name[..<indexOfComma]
  let firstNameSubstring = name[indexOfComma...].dropFirst(2)

  return firstNameSubstring + " " + lastNameSubstring
}

if let sanitizedName = sanitized(name: "Galloway, Matt") {
  print(sanitizedName)
}


/*:
 ### Challenge 4: Components

 A method exists on a string named `components(separatedBy:)` that will split the string into chunks, which are delimited by the given string, and return an array containing the results.
 
 Your challenge is to implement this yourself.
 
 Hint: There exists a view on `String` named `indices` that lets you iterate through all the indices (of type `String.Index`) in the string. You will need to use this.
 */

func splitting(_ string: String, delimiter: Character) -> [String] {
  var returnArray: [String] = []
  var lastWordIndex = string.startIndex

  for i in string.indices {
    if string[i] == delimiter {
      let substring = string[lastWordIndex..<i]
      returnArray.append(String(substring))
      lastWordIndex = string.index(after: i)
    }
  }

  // Add the final word
  let substring = string[lastWordIndex..<string.endIndex]
  returnArray.append(String(substring))

  return returnArray
}

let pieces = splitting("Dog,Cat,Badger,Snake,Lion", delimiter: ",")
print(pieces)


/*:
 ### Challenge 5: Word reverser
 Write a function which takes a string and returns a version of it with each individual word reversed.
 
 For example, if the string is “My dog is called Rover” then the resulting string would be "yM god si dellac revoR".
 
 Try to do it by iterating through the `indices` of the string until you find a space, and then reversing what was before it. Build up the result string by continually doing that as you iterate through the string.
 
 Hint: You’ll need to do a similar thing as you did for Challenge 4 but reverse the word each time. Try to explain to yourself, or the closest unsuspecting family member, why this is better in terms of memory usage than using the function you created in the previous challenge.
 */

func reversedByWord(sentence: String) -> String {
  var reversedWords = ""
  var lastWordIndex = sentence.startIndex

  for i in sentence.indices {
    if sentence[i] == " " {
      let substring = sentence[lastWordIndex..<i]
      reversedWords += substring.reversed() + " "
      lastWordIndex = sentence.index(after: i)
    }
  }

  // Add the final word
  let substring = sentence[lastWordIndex..<sentence.endIndex]
  reversedWords += substring.reversed()

  return reversedWords
}

let reversed = reversedByWord(sentence: "The quick brown fox jumps over the lazy dog")
print(reversed)
