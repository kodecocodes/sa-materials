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

// COMPARISON OPERATORS
//let yes: Bool = true
//let no: Bool = false
let yes = true
let no = false

let doesOneEqualTwo = (1 == 2)
let doesOneNotEqualTwo = (1 != 2)
let alsoTrue = !(1 == 2)
let isOneGreaterThanTwo = (1 > 2)
let isOneLessThanTwo = (1 < 2)

let and = true && true
let or = true || false

let andTrue = 1 < 2 && 4 > 3
let andFalse = 1 < 2 && 3 > 4

let orTrue = 1 < 2 || 3 > 4
let orFalse = 1 == 2 || 3 == 4

let andOr = (1 < 2 && 3 > 4) || 1 < 4

let guess = "dog"
let dogEqualsCat = guess == "cat"

let order = "cat" < "dog"

var switchState = true
switchState.toggle()
switchState.toggle()

// IF-STATEMENTS
if 2 > 1 {
  print("Yes, 2 is greater than 1.")
}

let animal = "Fox"
if animal == "Cat" || animal == "Dog" {
  print("Animal is a house pet.")
} else {
  print("Animal is not a house pet.")
}

let hourOfDay = 12
var timeOfDay = ""

if hourOfDay < 6 {
  timeOfDay = "Early morning"
} else if hourOfDay < 12 {
  timeOfDay = "Morning"
} else if hourOfDay < 17 {
  timeOfDay = "Afternoon"
} else if hourOfDay < 20 {
  timeOfDay = "Evening"
} else if hourOfDay < 24 {
  timeOfDay = "Late evening"
} else {
  timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)

let name = "Matt Galloway"

if 1 > 2 && name == "Matt Galloway" {
  // ...
}

if 1 < 2 || name == "Matt Galloway" {
  // ...
}


// SCOPE
var hoursWorked = 45

var price = 0
if hoursWorked > 40 {
  let hoursOver40 = hoursWorked - 40
  price += hoursOver40 * 50
  hoursWorked -= hoursOver40
}
price += hoursWorked * 25

print(price)
//print(hoursOver40)


// TERNARY OPERATOR
let a = 5
let b = 10

/*
 let min: Int
 if a < b {
   min = a
 } else {
   min = b
 }
 */
let min = a < b ? a : b

/*
 let max: Int
 if a > b {
   max = a
 } else {
   max = b
 }
 */
let max = a > b ? a : b


// WHILE LOOPS
// while true {} // Commented out as this will loop forever

// Made up sequence (it's powers of 2 minus 1, i.e. 3, 7, 15, 31, 63, etc)
var sum = 1
while sum < 1000 {
  sum = sum + (sum + 1)
}
sum

sum = 1
repeat {
  sum = sum + (sum + 1)
} while sum < 1000
sum

sum = 1
while sum < 1 {
  sum = sum + (sum + 1)
}
sum

sum = 1
repeat {
  sum = sum + (sum + 1)
} while sum < 1
sum

sum = 1
while true {
  sum = sum + (sum + 1)
  if sum >= 1000 {
    break
  }
}
sum
