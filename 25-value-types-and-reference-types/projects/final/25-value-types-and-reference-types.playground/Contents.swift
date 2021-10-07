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

let azurePaint = Bucket(color: .blue)
let wallBluePaint = azurePaint
wallBluePaint.isRefilled // => false, initially
azurePaint.refill()
wallBluePaint.isRefilled // => true, unsurprisingly!

extension Color {
  mutating func darken() {
    red *= 0.9; green *= 0.9; blue *= 0.9
  }
}

var azure = Color.blue
var wallBlue = azure
azure  // r: 0.0 g: 0.0 b: 1.0
wallBlue.darken()
azure  // r: 0.0 g: 0.0 b: 1.0 (unaffected)


class ReferenceType { var value = 0 }
struct ValueType { var value = 0 }

typealias MysteryType = ReferenceType
// or
// typealias MysteryType = ValueType

func exposeValue(_ mystery: MysteryType) -> Int {
  mystery.value
}

var x = MysteryType()
var y = x
exposeValue(x) // => initial value derived from x
// {code here which uses only y}
y.value = 10
exposeValue(x) // => final value derived from x
// Q: are the initial and final values different?


do {
  // No copy-on-write
  
  struct PaintingPlan { // a value type, containing ...
    // a value type
    var accent = Color.white
    // a mutable reference type
    var bucket = Bucket(color: .blue)
  }
  
  let artPlan = PaintingPlan()
  let housePlan = artPlan
  artPlan.bucket.color // => blue
  // for house-painting only we fill the bucket with green paint
  housePlan.bucket.color = Color.green
  artPlan.bucket.color // => green. oops!

  /*
   A side note: In the code above, the Swift compiler complains that artPlan
   and housePlan are never mutated and so could be changed to let constants.

   In what sense are they are never being mutated, even though we are changing
   the color in their bucket? Because from the compiler's point of view,
   the _value_ of this PaintingPlan is determined by _which_ bucket it
   points to, not the value of the paint in the bucket. This is because
   Bucket is a reference type.
   */
  
} // end of scope, so we can try again

do {
  // Copy-on-write
  
  struct PaintingPlan { // a value type, containing ...
    // a value type
    var accent = Color.white
    // a private reference type, for "deep storage"
    private var bucket = Bucket(color: .blue)
    
    // a pseudo-value type, using the deep storage
    var bucketColor: Color {
      get {
        bucket.color
      }
      set {
        bucket = Bucket(color: newValue)
      }
    }
  }
  
  let artPlan = PaintingPlan()
  var housePlan = artPlan
  housePlan.bucketColor = Color.green
  artPlan.bucketColor // blue. better!

  /*
   To continue the side note: The compiler does not complain that the variables
   could be constants here, because from its point of view they are being
   mutated, because bucketColor is a value type.
   */
  
} // end of do scope, so you can try again!


do {
// Copy-on-write, but only copy when you absolutely have to

  struct PaintingPlan { // a value type, containing ...
    // a value type
    var accent = Color.white
    // a private reference type, for "deep storage"
    private var bucket = Bucket(color: .blue)
    
    // a computed property facade over deep storage
    // with copy-on-write and in-place mutation when possible
    var bucketColor: Color {
      get {
        bucket.color
      }
      set {
        if isKnownUniquelyReferenced(&bucket) {
          bucket.color = bucketColor
        } else {
          bucket = Bucket(color: newValue)
        }
      }
    }
  }
  
  let artPlan = PaintingPlan()
  var housePlan = artPlan
  housePlan.bucketColor = Color.green
  artPlan.bucketColor // blue. good!

} // end of do scope, so you can try again

