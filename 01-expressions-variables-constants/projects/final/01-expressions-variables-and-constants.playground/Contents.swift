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

// COMMENTS
// This is a comment. It is not executed.

// This is also a comment.
// Over multiple lines.

/* This is also a comment.
   Over many..
   many...
   many lines. */

/* This is a comment.

 /* And inside it
 is
 another comment.
 */

 Back to the first.
 */


// PRINT
print("Hello, Swift Apprentice reader!")


// ARITHMETIC
2 + 6

10 - 2

2 * 4

24 / 3

2+6

22 / 7

22.0 / 7.0

28 % 10

(28.0).truncatingRemainder(dividingBy: 10.0)

1 << 3

32 >> 2

((8000 / (5 * 10)) - 32) >> (29 % 5)

350 / 5 + 2

350 / (5 + 2)


// MATH FUNCTIONS
sin(45 * Double.pi / 180)

cos(135 * Double.pi / 180)

(2.0).squareRoot()

max(5, 10)

min(-5, -10)

max((2.0).squareRoot(), Double.pi / 2)


// VARIABLES & CONSTANTS
let number: Int = 10
//number = 0 /* Cannot assign to value: 'constantNumber' is a 'let' constant */

let pi: Double = 3.14159

var variableNumber: Int = 42
variableNumber = 0
variableNumber = 1_000_000

var 🐶💩: Int = -1


// ARITHMETIC WITH VARIABLES
var counter: Int = 0
counter += 1
counter -= 1

counter = 10
counter *= 3
counter /= 2
