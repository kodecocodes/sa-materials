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
 ## Basic Control Flow
 ### Challenge 1: Find the error
 What’s wrong with the following code?
 
 ```
 let firstName = "Matt"
 
 if firstName == "Matt" {
   let lastName = "Galloway"
 } else if firstName == "Ray" {
   let lastName = "Wenderlich"
 }
 let fullName = firstName + " " + lastName
 ```
 */
// `lastName` is no longer in scope when setting `fullName`.
// A correct solution:
let firstName = "Matt"
var lastName = ""

if firstName == "Matt" {
  lastName = "Galloway"
} else if firstName == "Ray" {
  lastName = "Wenderlich"
}

let fullName = firstName + " " + lastName

/*:
 ### Challenge 2: Boolean challenge
 In each of the following statements, what is the value of the Boolean `answer` constant?
 */

let answer1 = true && true
// true

let answer2 = false || false
// false

let answer3 = (true && 1 != 2) || (4 > 3 && 100 < 1)
// true

let answer4 = ((10 / 2) > 3) && ((10 % 2) == 0)
// true

/*:
 ### Challenge 3: Snakes and ladders
 Imagine you're playing a game of snakes & ladders that goes from position 1 to position 20. On it, there are ladders at position 3 and 7 which take you to 15 and 12 respectively. Then there are snakes at positions 11 and 17 which take you to 2 and 9 respectively.

 Create a constant called `currentPosition` which you can set to whatever position between 1 and 20 which you like. Then create a constant called `diceRoll` which you can set to whatever roll of the dice you want. Finally, calculate the final position taking into account the ladders and snakes, calling it `nextPosition`.
 */
let currentPosition = 2
let diceRoll = 5

var nextPosition = currentPosition + diceRoll
if nextPosition == 3 {
  nextPosition = 15
} else if nextPosition == 7 {
  nextPosition = 12
} else if nextPosition == 11 {
  nextPosition = 2
} else if nextPosition == 17 {
  nextPosition = 9
}

print("Board position after \(currentPosition) is \(nextPosition)")

/*:
 ### Challenge 4: Number of days in a month
 Given a year reprsented by an `Int` and a month represented by a `String` in all lowercase and using the first three letters, calculate the number of days in the month. You need to account for leap years remembering that February ("feb") has 29 days in a leap year and 28 otherwise. A leap year occurs every 4 years, unless the year is divisible by 100, but then if it's divisible by 400 then it is actually a leap year.
 */
let month = "feb"
let year = 2016

var days = 0
if month == "jan" || month == "mar" || month == "may" || month == "jul" || month == "aug" || month == "oct" || month == "dec" {
  days = 31
} else if month == "apr" || month == "jun" || month == "sep" || month == "nov" {
  days = 30
} else if month == "feb" {
  if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
    days = 29
  } else {
    days = 28
  }
}

if days > 0 {
  print("\(month) has 31 days")
} else {
  print("Invalid month!")
}

/*:
 ### Challenge 5: Next power of two
 Given a number, determine the next power of 2 above or equal to that number.
 */
let number = 946
var trial = 1
var times = 0
while trial < number {
  trial = trial * 2
  times += 1
}
print("Next power of 2 >= \(number) is \(trial) which is 2 to the power of \(times)")

/*:
 ### Challenge 6: Triangular number
 Given a number, print the triangular number of that depth. You can get a refresher of triangular numbers here: https://en.wikipedia.org/wiki/Triangular_number
 */
var depth = 5
var count = 1
var triangularNumber = 0
while count <= depth {
  triangularNumber += count
  count += 1
}
print("Triangular number with depth \(depth) is \(triangularNumber)")

/*:
 ### Challenge 7: Fibonacci
 Calculate the n'th Fibonacci number. Remember that Fibonacci numbers start its sequence with 1 and 1, and then subsequent numbers in the sequence are equal to the previous two values added together. You can get a refresher here: https://en.wikipedia.org/wiki/Fibonacci_number
 */
let n = 10
var current = 1
var previous = 1
var done = 2
while done < n {
  let next = current + previous
  previous = current
  current = next
  done += 1
}
print("Fibonacci number \(n) is \(current)")

/*:
 ### Challenge 8: Make a loop
 Use a loop to print out the times table up to 12 of a given factor.
 */
let factor = 7

var i = 0
var accumulator = 0
while i <= 12 {
  print("\(factor) x \(i) = \(accumulator)")
  accumulator += 7
  i += 1
}

/*:
 ### Challenge 9: Dice roll table
 Print a table showing the number of combinations to create each number from 2 to 12 given 2 six-sided dice rolls. You should not use a formula but rather compute the number of combinations exhaustively by considering each possible dice roll.
 */
var target = 2

while target <= 12 {
  var combinationsFound = 0
  var valueOnFirstDice = 1
  while valueOnFirstDice <= 6 {
    var valueOnSecondDice = 1
    while valueOnSecondDice <= 6 {
      if valueOnFirstDice + valueOnSecondDice == target {
        combinationsFound += 1
      }
      valueOnSecondDice += 1
    }
    valueOnFirstDice += 1
  }

  print("\(target):\t\(combinationsFound)")

  target += 1
}
