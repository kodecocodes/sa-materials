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
//: ## Mini Exercises
//: ### Ordering Pizza
//: Write a structure that represents a pizza order. Include toppings, size and any other option you’d want for a pizza.
struct Pizza {
  let size: Int // Inches
  let toppings: [String] // Pepperoni, Mushrooms
  let style: String // Thick, Thin, Hand-tossed
}

let pizza = Pizza(size: 14, toppings: ["Pepperoni", "Mushrooms", "Anchovies"], style: "Thin")
//: ### Refactoring `isInDeliveryRange`
//: Rewrite `isInDeliveryRange` to use `Location` and `DeliveryArea`.
// The solution can be found right after the mini exercise, in the "Introducing methods" section
//: ### Refactoring `DeliveryArea`
//: 1. Change `distance(from:to:)` to use `Location`  as your parameters instead of x-y tuples.
struct Location {
  let x: Int
  let y: Int
}

func distance(from source: Location, to target: Location) -> Double {
  let distanceX = Double(source.x - target.x)
  let distanceY = Double(source.y - target.y)
  return sqrt(distanceX * distanceX + distanceY * distanceY)
}
//: 2. Change `contains(_:)` to call the new `distance(from:to:)` with `Location`.
// See below.
//: 3. Add a method `overlaps(with:)` on `DeliveryArea` that can tell you if the area overlaps with another area.
struct DeliveryArea {
  let center: Location
  var radius: Double
  
  func contains(_ location: Location) -> Bool {
    distance(from: center, to: location) < radius
  }
  
  func overlaps(with area: DeliveryArea) -> Bool {
    distance(from: center, to: area.center) <= (radius + area.radius)
  }
}

let area1 = DeliveryArea(center: Location(x: 3, y: 3), radius: 2.5)
let area2 = DeliveryArea(center: Location(x: 8, y: 8), radius: 2.5)
area1.overlaps(with: area2) // false

let area3 = DeliveryArea(center: Location(x: 4, y: 4), radius: 2.5)
let area4 = DeliveryArea(center: Location(x: 7, y: 7), radius: 2.5)
area3.overlaps(with: area4) // true
