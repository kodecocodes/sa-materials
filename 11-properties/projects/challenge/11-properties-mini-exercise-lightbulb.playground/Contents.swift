/// Copyright (c) 2020 Razeware LLC
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
 ## Properties Mini-exercise, Lightbulb
 In the light bulb example, the bulb goes back to a successful setting if the current gets too high. In real life, that wouldn’t work. The bulb would burn out!

 Your task is to rewrite the structure so that the bulb turns off before the current burns it out.

 Hint: You’ll need to use the `willSet` observer that gets called before value is changed. The value that is about to be set is available in the constant `newValue`. The trick is that you can’t change this `newValue`, and it will still be set, so you’ll have to go beyond adding a `willSet` observer. :]
*/
struct LightBulb {
  static let maxCurrent = 40
  var isOn = false
  var current = LightBulb.maxCurrent {
    willSet { // can observe the newValue, but can't change it
      if newValue > Self.maxCurrent {
        print("Current is too high, turning off to prevent burn out.")
        isOn = false
      }
    }
    didSet {
      if current > Self.maxCurrent {
        print("Current is too high, falling back to previous setting.")
        current = oldValue
      }
    }
  }
}

// Installing a new bulb
var bulb = LightBulb() // Light bulb is off

// Flipping the switch
bulb.isOn = true // Light bulb is ON with 40 amps

// Using the dimmer
bulb.current = 30 // Light bulb is ON with 30 amps

// Using the dimmer to a high value
bulb.current = 50 // Light bulb is OFF

// Flipping the switch
bulb.isOn = true // Light bulb is ON with 30 amps
