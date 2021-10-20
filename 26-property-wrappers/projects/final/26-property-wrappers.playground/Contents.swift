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

@propertyWrapper
struct ZeroToOne {
  private var value: Double

  private static func clamped(_ input: Double) -> Double {
    min(max(input, 0), 1)
  }

  init(wrappedValue: Double) {
    value = Self.clamped(wrappedValue)
  }

  var wrappedValue: Double {
    get { value }
    set { value =  Self.clamped(newValue) }
  }
}

@propertyWrapper
struct ZeroToOneV2 {
  private var value: Double

  init(wrappedValue: Double) {
    value = wrappedValue
  }

  var wrappedValue: Double {
    get { min(max(value, 0), 1) }
    set { value = newValue }
  }

  var projectedValue: Double { value }
}

@propertyWrapper
struct ZeroTo<Value: Numeric & Comparable> {
  private var value: Value
  let upper: Value

  init(wrappedValue: Value, upper: Value) {
    value = wrappedValue
    self.upper = upper
  }

  var wrappedValue: Value {
    get { min(max(value, 0), upper) }
    set { value = newValue }
  }

  var projectedValue: Value { value }
}


struct Color: CustomStringConvertible {
  @ZeroToOne var red: Double
  @ZeroToOne var green: Double
  @ZeroToOne var blue: Double

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

var superRed = Color(red: 2, green: 0, blue: 0)
print(superRed) // r: 1, g: 0, b: 0
superRed.blue = -2
print(superRed) // r: 1, g: 0, b: 0

func printValue(@ZeroToOne _ value: Double) {
  print("The wrapped value is", value)
}

printValue(3.14)

func printValueV2(@ZeroToOneV2 _ value: Double) {
  print("The wrapped value is", value)
  print("The projected value is", $value)
}

printValueV2(3.14)

func printValueV3(@ZeroTo(upper: 10) _ value: Double) {
  print("The wrapped value is", value)
  print("The projected value is", $value)
}
printValueV3(42)

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
        bucket = Bucket(color: newValue)
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
// which requires strings to fit a specific format

@propertyWrapper
public struct ValidatedDate {
    
  private var storage: Date? = nil
  private(set) var formatter = DateFormatter()

  public init(wrappedValue: String) {
    self.formatter.dateFormat = "yyyy-mm-dd"
    self.wrappedValue = wrappedValue
  }

  public var wrappedValue: String {
    set {
      self.storage = formatter.date(from: newValue)
    }
    get {
      if let date = self.storage {
        return formatter.string(from: date)
      } else {
        return "invalid"
      }
    }
  }
  
  public var projectedValue: DateFormatter {
    get { formatter }
    set { formatter = newValue }
  }
}

struct Order {
  
  @ValidatedDate var orderPlacedDate: String = ""
//  @ValidatedDate var shippingDate: String
//  @ValidatedDate var deliveredDate: String
}

var order = Order()
// store a valid date string
order.orderPlacedDate = "2014-06-02"
order.orderPlacedDate // => 2014-06-02
// try to store an invalid date
order.orderPlacedDate = "2015-06-50"
// observe that all you can read back is "invalid"
order.orderPlacedDate // => "invalid"
order.orderPlacedDate = "2014-06-02"

// update the date format using the projected value
let otherFormatter = DateFormatter()
otherFormatter.dateFormat = "mm/dd/yyyy"
order.$orderPlacedDate = otherFormatter
// read the string in the new format
order.orderPlacedDate // => "06/02/2014"

