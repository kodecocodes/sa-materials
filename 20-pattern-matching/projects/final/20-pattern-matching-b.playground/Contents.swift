/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
//: ## Chapter 20: Pattern Matching, B
func fibonacci(position: Int) -> Int {
  switch position {
  case let n where n <= 1:
    return 0
  case 2:
    return 1
  case let n:
    return fibonacci(position: n - 1) + fibonacci(position: n - 2)
  }
}
let fib15 = fibonacci(position: 15)

for i in 1...100 {
  switch (i % 3, i % 5) {
  case (0, 0):
    print("FizzBuzz", terminator: " ")
  case (0, _):
    print("Fizz", terminator: " ")
  case (_, 0):
    print("Buzz", terminator: " ")
  case (_, _):
    print(i, terminator: " ")
  }
}
print("")

let matched = (1...10 ~= 5)

if case 1...10 = 5 {
  print("In the range")
}

func ~=(pattern: [Int], value: Int) -> Bool {
  for i in pattern {
    if i == value {
      return true
    }
  }
  return false
}

let list = [0, 1, 2, 3]
let integer = 2

let isInArray = (list ~= integer)

if case list = integer {
  print("The integer is in the array")
} else {
  print("The integer is not in the array")
}

let isInList = list.contains(integer)
