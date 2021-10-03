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
 ## Types and Operations
 ### Challenge 1: Coordinates
 Create a constant called `coordinates` and assign a tuple containing two and three to it.
 */
let coordinates = (2, 3)

/*:
 ## Types and Operations
 ### Challenge 2: Named coordinate
 Create a constant called `namedCoordinate` with a `row` and `column` component of 2 and 3.
 */
let namedCoordinate = (row: 2, column: 3)

/*:
 ### Challenge 3: Which are valid?
 Which of the following are valid statements?
*/
//let character: Character = "Dog" // INVALID
//let character: Character = "🐶" // VALID
//let string: String = "Dog" // VALID
//let string: String = "🐶" // VALID

/*:
 ### Challenge 4. Does it compile?
 Is this valid code?
*/
let tuple = (day: 15, month: 8, year: 2015)
//let day = tuple.Day // Invalid because it should be 'day' instead of 'Day'

/*:
 ### Challenge 5: Find the error
 What is wrong with the following code?
*/
let name = "Matt"
//name += " Galloway" // 'name' is a constant, so you can't change its value

/*:
 ### Challenge 6: What is the type of `value`?
 What is the type of the constant called `value`?
 */
let value = tuple.1 // value = 8 of type Double

/*:
 ### Challenge 7: What is the value of month?
 What is the value of the constant called `month`?
*/
let month = tuple.month // month = 8

/*:
 ### Challenge 8: What is the value of `summary`?
 What is the value of the constant called `summary`?
 */
let number = 10
let multiplier = 5
let summary = "\(number) multiplied by \(multiplier) equals \(number * multiplier)"
// summary = "10 multiplied by 5 equals 50"

/*:
 ### Challenge 9: Compute the value
  What is the sum of `a` and `b`, minus `c`?
 */
let a = 4
let b: Int32 = 100
let c: UInt8 = 12
let answer = a + Int(b) - Int(c)

/*:
 ### Challenge 10: Different precision 𝜋s
 What is the difference between `Double.pi` and `Float.pi`?
 */
let difference = Double.pi - Double(Float.pi)

// Float is a little less accurate so it makes sense to promote it to
// a Double. Double is more accurate but it is not exact! That 
// would require an infinite number of bits. :]
//
// 1.50995798975373e-07, or 0.000000150995798975373
