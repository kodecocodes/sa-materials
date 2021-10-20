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
/*:
 ## Properties Challenge 2
 
At the beginning of the chapter, you saw a `Car` structure. Dive into the inner workings of the car and rewrite the `FuelTank` structure below with property observer functionality:

```swift
 /// struct FuelTank {
 ///   var level: Double // decimal percentage between 0 and 1
 /// }
```
  1. Add a `lowFuel` stored property of Boolean type to the structure.
  2. Flip the `lowFuel` Boolean when the `level` drops below 10%.
  3. Ensure that when the tank fills back up, the `lowFuel` warning will turn off.
  4. Set the `level` to a minimum of `0` or a maximum of `1` if it gets set above or below the expected values.
  5. Add a `FuelTank` property to `Car`.
 */
struct FuelTank {

  var lowFuel: Bool
  var level: Double { // decimal percentage between 0 and 1
    didSet {
      if level < 0 {
        level = 0
      }
      if level > 1 {
        level = 1
      }
      lowFuel = level < 0.1
    }
  }
}

struct Car {
  let make: String
  let color: String
  var tank: FuelTank
}

var car = Car(make: "DeLorean", color: "Silver", tank: FuelTank(lowFuel: false, level: 1))
car.tank.level = -1 // level: 0, lowFuel: true
car.tank.level = 1.1 // level: 1, lowFuel: false
