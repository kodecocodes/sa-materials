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

/*:
 ## Error Handling
 ### Challenge 1: Even strings
 Write a throwing function that converts a `String` to an even number, rounding down if necessary.
 */

enum NumberError: Error {
  case notANumber
}

func toEvenNumber(_ string: String) throws -> Int {
  guard let number = Int(string) else {
    throw NumberError.notANumber
  }
  return number - number % 2
}

do {
  // try toEvenNumber("abc")
  // try toEvenNumber("10")
  // try toEvenNumber("1")
  try toEvenNumber("4")
} catch {
  print("You can't convert the string to a number!")
}

/*:
 ### Challenge 2: Safe division
 Write a throwing function that divides two Int types.
 */

enum DivisionError: Error {
  case divisionByZero
}

func divide(_ x: Int, _ y: Int) throws -> Int {
  guard y != 0 else {
    throw DivisionError.divisionByZero
  }
  return x/y
}

do {
  // try divide(10, 0)
  try divide(10, 2)
} catch {
  print("You can't divide by zero!")
}


