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

import Foundation
/*:
 ## Protocol Oriented Programming
 ### Challenge 1: Protocol extension practice
 Suppose you own a retail store. You have food items, clothes and electronics. Begin with an `Item` protocol:
 
```swift
protocol Item {
  var name: String { get }
  var clearance: Bool { get }
  var msrp: Double { get }
  var totalPrice: Double { get }
}
```
 
 Fulfill the following requirements using primarily what you’ve learned about protocol-oriented programming. In other words, minimize the code in your classes, structs or enums.
 
 * Clothes do not have sales tax, but all other items have 7.5% sales tax.
 * When on clearance, food items are discounted 50%, clothes are discounted 25% and electronics are discounted 5%.
 * Items should implement `CustomStringConvertible` and return `name`. Food items should also print their expiration dates.
 */
protocol Item: CustomStringConvertible {
  var name: String { get }
  var clearance: Bool { get }
  var msrp: Double { get } // Manufacturer's Suggested Retail Price
  var totalPrice: Double { get }
}

protocol Taxable: Item {
  var taxPercentage: Double { get }
}

protocol Discountable: Item {
  var adjustedMsrp: Double { get }
}

extension Item {
  var description: String {
    name
  }
}

extension Item {
  var totalPrice: Double {
    msrp
  }
}

extension Item where Self: Taxable {
  var totalPrice: Double {
    msrp * (1 + taxPercentage)
  }
}

extension Item where Self: Discountable {
  var totalPrice: Double {
    adjustedMsrp
  }
}

extension Item where Self: Taxable & Discountable {
  var totalPrice: Double {
    adjustedMsrp * (1 + taxPercentage)
  }
}

struct Clothing: Discountable {
  let name: String
  var msrp: Double
  var clearance: Bool

  var adjustedMsrp: Double {
    msrp * (clearance ? 0.75 : 1.0)
  }
}

struct Electronics: Taxable, Discountable {
  let name: String
  var msrp: Double
  var clearance: Bool

  let taxPercentage = 0.075

  var adjustedMsrp: Double {
    msrp * (clearance ? 0.95 : 1.0)
  }
}

struct Food: Taxable {
  let name: String
  var msrp: Double
  var clearance: Bool
  let expirationDate: (month: Int, year: Int)

  let taxPercentage = 0.075

  var adjustedMsrp: Double {
    msrp * (clearance ? 0.50 : 1.0)
  }

  var description: String {
    "\(name) - expires \(expirationDate.month)/\(expirationDate.year)"
  }
}

Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016)).totalPrice
Clothing(name: "Shirt", msrp: 12.99, clearance: true).totalPrice
Clothing(name: "Last season shirt", msrp: 12.99, clearance: false).totalPrice
Electronics(name: "Apple TV", msrp: 139.99, clearance: false).totalPrice
Electronics(name: "Apple TV 3rd gen", msrp: 99.99, clearance: true).totalPrice

// Custom string convertible demonstration
Food(name: "Bread", msrp: 2.99, clearance: false, expirationDate: (11, 2016))
Electronics(name: "Apple TV 3rd gen", msrp: 99.99, clearance: true)
/*:
 ### Challenge 2: Doubling values
 
 Write a protocol extension on `Sequence` named `double()` that only applies to sequences of numeric elements. Make it return an array where each element is twice the element in the sequence. Test your implementation on an array of `Int` and an array of `Double`, then see if you can try it on an array of `String`.
 
 Hints:
 
 * Numeric values implement the protocol `Numeric`.
 * Your method signature should be `double() -> [Element]`. The type `[Element]` is an array of whatever type the `Sequence` holds, such as `String` or `Int`.
 */
extension Sequence where Element: Numeric {
  func double() -> [Element] {
    self.map { $0 * 2 }
  }
}

[10, 11, 12, 13, 14, 15].double()
[1.1, 1.2, 1.3, 1.4, 1.5].double()
//["1", "2", "3"].doubled() // No doubled() available here as String is not Numeric.
