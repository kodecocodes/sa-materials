/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
//: ## Chapter 20: Pattern Matching, B (latter half of the chapter)

import Foundation

func fibonacci(position: Int) -> Int {
  switch position {
  // 1
  case let n where n <= 1:
    return 0 // 2
  case 2:
    return 1
// 3
  case let n:
    return fibonacci(position: n - 1) + fibonacci(position: n - 2)
  }
}

let fib15 = fibonacci(position: 15) // 377

for i in 1...100 {
  // 1
  switch (i % 3, i % 5) {
  // 2
  case (0, 0):
    print("FizzBuzz", terminator: " ")
  case (0, _):
    print("Fizz", terminator: " ")
  case (_, 0):
    print("Buzz", terminator: " ")
  // 3
case (_, _):
    print(i, terminator: " ")
  }
}
print("")

let matched = (1...10 ~= 5) // true

if case 1...10 = 5 {
 print("In the range")
}

let list = [0, 1, 2, 3]
let integer = 2

// 1
func ~=(pattern: [Int], value: Int) -> Bool {
  // 2
  for i in pattern {
    if i == value {
      // 3
      return true
    }
  }
  // 4
  return false
}

let isInArray = (list ~= integer) // true
if case list = integer {
  print("The integer is in the array") // Printed!
} else {
  print("The integer is not in the array")
}
