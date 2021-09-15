/**
 * Copyright (c) 2020 Razeware LLC
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

struct Color: CustomStringConvertible {
  var red, green, blue: Double

  var description: String {
    "r: \(red) g: \(green) b: \(blue)"
  }
}

// Preset colors
extension Color {
  static var black = Color(red: 0, green: 0, blue: 0)
  static var white = Color(red: 1, green: 1, blue: 1)
  static var blue  = Color(red: 0, green: 0, blue: 1)
  static var green = Color(red: 0, green: 1, blue: 0)
  // more ...
}

// Paint bucket abstraction
class Bucket {
  var color: Color
  var isRefilled = false

  init(color: Color) {
    self.color = color
  }

  func refill() {
    isRefilled = true
  }
}


// Copy-on-write, using a property wrapper

// a property wrapper, named CopyOnWriteColor
@propertyWrapper
struct CopyOnWriteColor {
  // ... which can be initialized with a Color,
  // thus allowing the wrapped property to be initialized with Color
  init(wrappedValue: Color) {
    self.bucket = Bucket(color: wrappedValue)
  }

  // ...  defining a private property, which holds the storage
  private var bucket: Bucket

  // ... defining a wrappedValue with computed properties, which
  // implement the usual copy-on-write logic
  var wrappedValue: Color {
    get {
      bucket.color
    }
    set {
      if isKnownUniquelyReferenced(&bucket) {
        bucket.color = newValue
      } else {
        bucket = Bucket(color:newValue)
      }
    }
  }
}


struct PaintingPlan {

  // a value semantic type, which is a simple value type
  var accent = Color.white

  // a value semantic type, backed by a reference type managed by a property wrapper
  @CopyOnWriteColor var bucketColor = .blue
  // ... and another, without any code duplication
  @CopyOnWriteColor var bucketColorForDoor = .blue
  // ... and another, without any code duplication
  @CopyOnWriteColor var bucketColorForWalls = .blue
}

var artPlan = PaintingPlan()
var housePlan = artPlan
housePlan.bucketColor = Color.green
artPlan.bucketColor // blue. good!

// ValidatedDate property wrapper,
// which requires strings to fit yyyy-mm-dd format

@propertyWrapper
public struct ValidatedDate {
  private var storage:Date? = nil
  private let formatter = DateFormatter()

  public init(wrappedValue:String) {
    self.wrappedValue = wrappedValue
    self.formatter.dateFormat = "yyyy-mm-dd"
  }

  public var wrappedValue:String {
    set {
      self.storage = formatter.date(from:newValue)
    }
    get {
      if let m = self.storage { return formatter.string(from:m) }
      else { return "invalid" }
    }
  }
}

struct Order {
  @ValidatedDate var orderPlacedDate:String = ""
//  @ValidatedDate var shippingDate:String
//  @ValidatedDate var deliveredDate:String
}

// using projected value to change the PW's behavior
var o1 = Order()
o1.orderPlacedDate = "2014-06-02" // store a valid date string
o1.orderPlacedDate // => 2014-06-02
// try to store an invalid date
o1.orderPlacedDate = "2015-06-50"
// observe that all you can read back is "invalid"
o1.orderPlacedDate // => "invalid"

// ValidatedDate2 property wrapper,
// which lets you configure the enforced date formatting

@propertyWrapper
public struct ValidatedDate2 {

  private var storage:Date? = nil
  private let formatter = DateFormatter()

  public init(wrappedValue:String) {
    self.wrappedValue = wrappedValue
    self.formatter.dateFormat = "yyyy-mm-dd"
  }

  public var wrappedValue:String {
    set {
      self.storage = formatter.date(from:newValue)
    }
    get {
      if let m = self.storage { return formatter.string(from:m) }
      else { return "invalid" }
    }
  }

  public var projectedValue:String = "yyyy-mm-dd" {
    didSet {
      formatter.dateFormat = projectedValue
    }
  }
}

struct Order2 {
  @ValidatedDate2 var orderPlacedDate:String = ""
//  @ValidatedDate var shippingDate:String
//  @ValidatedDate var deliveredDate:String
}

// using projected value to change the PW's behavior
var o2 = Order2()
o1.orderPlacedDate = "2014-06-02" // store a valid date string
o1.orderPlacedDate // => 2014-06-02
// update the date format using the projected value
o2.$orderPlacedDate = "mm/dd/yyyy"
o1.orderPlacedDate // => 06/02/2014" // read the string under new wrapping logic

