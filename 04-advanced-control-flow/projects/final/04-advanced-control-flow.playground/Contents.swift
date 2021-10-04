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

// RANGES
let closedRange = 0...5

let halfOpenRange = 0..<5

while Int.random(in: 1...6) != 6 {
  print("Not a six")
}

// FOR LOOPS
let count = 10

// Triangle numbers
var sum = 0
for i in 1...count {
  sum += i
}
sum

// Fibonacci
sum = 1
var lastSum = 0
for _ in 0..<count {
  let temp = sum
  sum = sum + lastSum
  lastSum = temp
}
sum

// Sum odd numbers
sum = 0
for i in 1...count where i % 2 == 1 {
  sum += i
}
sum

// Chess board iteration
sum = 0
for row in 0..<8 {
  if row % 2 == 0 {
    continue
  }
  
  for column in 0..<8 {
    sum += row * column
  }
}
sum

sum = 0
rowLoop: for row in 0..<8 {
  columnLoop: for column in 0..<8 {
    if row == column {
      continue rowLoop
    }
    sum += row * column
  }
}
sum


// SWITCH STATEMENTS
let number = 10

switch number {
case 0:
  print("Zero")
default:
  print("Non-zero")
}

switch number {
case 10:
  print("It's ten!")
default:
  break
}

let string = "Dog"
switch string {
case "Cat", "Dog":
  print("Animal is a house pet.")
default:
  print("Animal is not a house pet.")
}

let hourOfDay = 12
var timeOfDay = ""

//switch hourOfDay {
//case 0, 1, 2, 3, 4, 5:
//  timeOfDay = "Early morning"
//case 6, 7, 8, 9, 10, 11:
//  timeOfDay = "Morning"
//case 12, 13, 14, 15, 16:
//  timeOfDay = "Afternoon"
//case 17, 18, 19:
//  timeOfDay = "Evening"
//case 20, 21, 22, 23:
//  timeOfDay = "Late evening"
//default:
//  timeOfDay = "INVALID HOUR!"
//}

switch hourOfDay {
case 0...5:
  timeOfDay = "Early morning"
case 6...11:
  timeOfDay = "Morning"
case 12...16:
  timeOfDay = "Afternoon"
case 17...19:
  timeOfDay = "Evening"
case 20..<24:
  timeOfDay = "Late evening"
default:
  timeOfDay = "INVALID HOUR!"
}
print(timeOfDay)

switch number {
case let x where x % 2 == 0:
  print("Even")
default:
  print("Odd")
}

switch number {
case _ where number % 2 == 0:
  print("Even")
default:
  print("Odd")
}

let coordinates = (x: 3, y: 2, z: 5)

switch coordinates {
case (0, 0, 0):
  print("Origin")
case (_, 0, 0):
  print("On the x-axis.")
case (0, _, 0):
  print("On the y-axis.")
case (0, 0, _):
  print("On the z-axis.")
default:
  print("Somewhere in space")
}

switch coordinates {
case (0, 0, 0):
  print("Origin")
case (let x, 0, 0):
  print("On the x-axis at x = \(x)")
case (0, let y, 0):
  print("On the y-axis at y = \(y)")
case (0, 0, let z):
  print("On the z-axis at z = \(z)")
case let (x, y, z):
  print("Somewhere in space at x = \(x), y = \(y), z = \(z)")
}

switch coordinates {
case let (x, y, _) where y == x:
  print("Along the y = x line.")
case let (x, y, _) where y == x * x:
  print("Along the y = x^2 line.")
default:
  break
}
