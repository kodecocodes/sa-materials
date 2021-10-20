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
 ## Advanced Control Flow
 ### Challenge 1: How many times

 In the following for loop:
 
 ```
 var sum = 0
 for i in 0...5 {
   sum += i
 }
 ```
 What will be the value of `sum`, and how many iterations will happen?
 */
var sum = 0
for i in 0...5 {
  sum += i
}
sum

// sum = 15, 6 iterations (0, 1, 2, 3, 4, 5)

/*:
 ### Challenge 2: Count the letter
 
 In the while loop below:
 ````
 var aLotOfAs = ""
 while aLotOfAs.count < 10 {
   aLotOfAs += "a"
 }
 ````
 How many instances of the character “a” will there be in `aLotOfAs`? Hint: `aLotOfAs.count` will tell you how many characters there are in the string `aLotOfAs`.
 */
var aLotOfAs = ""
while aLotOfAs.count < 10 {
  aLotOfAs += "a"
}
aLotOfAs
aLotOfAs.count
// aLotOfAs contains 10 instances of "a"

/*:
 ### Challenge 3: What will print
 Consider the following switch statement:
 
 ```
 switch coordinates {
 case let (x, y, z) where x == y && y == z:
   print("x = y = z")
 case (_, _, 0):
   print("On the x/y plane")
 case (_, 0, _):
   print("On the x/z plane")
 case (0, _, _):
   print("On the y/z plane")
 default:
   print("Nothing special")
 }
 ```

 What will this code print when coordinates is each of the following?
 ```
 let coordinates = (1, 5, 0)
 let coordinates = (2, 2, 2)
 let coordinates = (3, 0, 1)
 let coordinates = (3, 2, 5)
 let coordinates = (0, 2, 4)
 ```
 */
let coordinates = (1, 5, 0)
// "On the x/y plane"

//let coordinates = (2, 2, 2)
// "x = y = z"

//let coordinates = (3, 0, 1)
// "On the x/z plane"

//let coordinates = (3, 2, 5)
// "Nothing special"

//let coordinates = (0, 2, 4)
// "On the y/z plane"

switch coordinates {
case let (x, y, z) where x == y && y == z:
  print("x = y = z")
case (_, _, 0):
  print("On the x/y plane")
case (_, 0, _):
  print("On the x/z plane")
case (0, _, _):
  print("On the y/z plane")
default:
  print("Nothing special")
}

/*:
 ### Challenge 4: Closed range size
 A closed range can never be empty. Why?
 */
// Ranges must always be increasing.  With a closed range the second number is always included in the range.

let halfOpenRange = 100..<100 // empty
let closedRange = 100...100   // contains the number 100

halfOpenRange.isEmpty
closedRange.isEmpty

/*:
 ### Challenge 5: The final countdown
 Print a countdown from 10 to 0.  (Note: do not use the `reversed()` method, which will be introduced later.)
 */
for i in 0...10 {
  print(10 - i)
}
/*:
 ### Challenge 6: Print a sequence
 
 Print 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0.  (Note: do not use the `stride(from:to:by:)` function, which will be introduced later.)
 */
var value = 0.0

for _ in 0...10 {
  print(value)
  value += 0.1
}

// Alternate solution
for counter in 0...10 {
  print(Double(counter) * 0.1)
}
