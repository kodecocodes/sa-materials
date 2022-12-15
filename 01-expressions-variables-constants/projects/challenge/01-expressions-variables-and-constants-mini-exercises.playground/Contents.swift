/**
 * Copyright (c) 2022 Kodeco Inc.
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
 ## Expressions, Variables & Constants Mini-exercises
 ### Exercise 1
Declare a constant of type `Int` called `myAge` and set it to your age.
 */
let myAge: Int = 25

/*:
 ### Exercise 2
 Declare a variable of type `Double` called `averageAge`. Initially, set it to your own age. Then, set it to the average of your age and then the age of `30`.
 */
var averageAge: Double = 25
averageAge = (averageAge + 30) / 2

/*:
 ### Exercise 3
 Create a constant called `testNumber` and initialize it with whatever integer you’d like. Next, create another constant called `evenOdd` and set it equal to `testNumber` modulo 2. Now change `testNumber` to various numbers. What do you notice about `evenOdd`?
 */
let testNumber: Int = 42
let evenOdd: Int = testNumber % 2
// 'evenOdd' is 0 when 'testNumber' is even. 'evenOdd' is 1 when 'testNumber' is odd.

/*:
 ### Exercise 4
 Create a variable called `answer` and initialize it with the value `0`. Increment it by `1`. Add `10` to it. Multiply it by `10`. Then, shift it to the right by `3`. After all of these operations, what’s the answer?
 */
var answer: Int = 0
answer += 1
answer += 10
answer *= 10
answer >>= 3
answer
// answer = 13
