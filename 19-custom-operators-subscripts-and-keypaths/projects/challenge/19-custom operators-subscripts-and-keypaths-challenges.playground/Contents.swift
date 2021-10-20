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

import CoreGraphics
/*:
 ## Custom Operators, Subscripts and Keypaths
 ### Challenge 1
 Modify the following subscript implementation so that it compiles in a playground:
 
 ```swift
 extension Array {
   subscript(index: Int) -> (String, String)? {
     guard let value = self[index] as? Int else {return nil}
     switch (value >= 0, abs(value) % 2) {
       case (true, 0): return ("positive", "even")
       case (true, 1): return ("positive", "odd")
       case (false, 0): return ("negative", "even")
       case (false, 1): return ("negative", "odd")
       default: return nil
     }
   }
 }
```
*/
extension Array {
  subscript(index index: Int) -> (String, String)? {
    guard let value = self[index] as? Int else {return nil}
    switch (value >= 0, abs(value) % 2) {
      case (true, 0): return ("positive", "even")
      case (true, 1): return ("positive", "odd")
      case (false, 0): return ("negative", "even")
      case (false, 1): return ("negative", "odd")
      default: return nil
    }
  }
}

let numbers = [-2, -1, 0, 1, 2]
numbers[index: 0]
numbers[index: 1]
numbers[index: 2]
numbers[index: 3]
numbers[index: 4]
/*:
 ### Challenge 2
 Write a subscript that computes the character at a certain index in a string.
 */
extension String {
  subscript(index: Int) -> Character? {
    guard 0..<count ~= index else {return nil}
    return self[self.index(startIndex, offsetBy: index)]
  }
}

let me = "Cosmin"
me[3]

// WARNING:
// While adding this method may seem convenient, there is a reason it is
// not in the standard library: it has linear time O(n) performance because
// unicode characters are not fixed width.
// Subscripts are expected to have constant time O(1) performance.
// It is all too easy to put this code in a loop and suddenly have very
// poor, battery-killing, server-killing performance.
/*:
 ### Challenge 3
 Implement the exponentiation generic operator for float types so that the following code works:
 
 ```swift
 let exponent = 2
 let baseDouble = 2.0
 var resultDouble = baseDouble ** exponent
 let baseFloat: Float = 2.0
 var resultFloat = baseFloat ** exponent
 let baseCG: CGFloat = 2.0
 var resultCG = baseCG ** exponent
 ```
 **Note**: You should import the `CoreGraphics` framework in order to work with `CGFloat`.
 */
infix operator **
func **<T: FloatingPoint>(base: T, power: Int) -> T {
  precondition(power >= 2)
  var result = base
  for _ in 2...power {
    result *= base
  }
  return result
}

let exponent = 2
let baseDouble = 2.0
var resultDouble = baseDouble ** exponent
let baseFloat: Float = 2.0
var resultFloat = baseFloat ** exponent
let baseCG: CGFloat = 2.0
var resultCG = baseCG ** exponent
/*:
### Challenge 4
Implement the exponentiation assignment generic operator for float types so that the following code works:
 
 ```swift
 resultDouble **= exponent
 resultFloat **= exponent
 resultCG **= exponent
 ```
*/
infix operator **=
func **=<T: FloatingPoint>(lhs: inout T, rhs: Int) {
  lhs = lhs ** rhs
}

resultDouble **= exponent
resultFloat **= exponent
resultCG **= exponent
