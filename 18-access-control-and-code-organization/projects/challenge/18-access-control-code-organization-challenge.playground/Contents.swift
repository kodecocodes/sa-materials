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

//: Challenge 1

class Logger {
  
  // A private initializer is required to restrict instantiation so only the class itself can create objects.
  private init() {}
  
  // The single, shared instance.
  static let sharedInstance = Logger()
  
  func log(_ text: String) {
    print(text)
  }
}

Logger.sharedInstance.log("Hello, Swift!")

//Logger().log("Can't do this :)") // Can't be instantiated outside of `Logger`

//: Challenge 2

struct Stack<Element> {
  
  private var elements: [Element] = []
  
  var count: Int {
    elements.count
  }
  
  func peek() -> Element? {
    elements.last
  }
  
  mutating func push(_ element: Element) {
    elements.append(element)
  }
  
  mutating func pop() -> Element? {
    if elements.isEmpty {
      return nil
    }
    return elements.removeLast()
  }
}

var strings = Stack<String>()

strings.push("Great!")
strings.push("is")
strings.push("Swift")

//strings.elements.removeAll() // The implementation details of `Stack` are hidden.

strings.peek()

while let string = strings.pop() {
  Logger.sharedInstance.log(string)
}

//: Challenge 3

let elf = GameCharacterFactory.make(ofType: .elf)
let giant = GameCharacterFactory.make(ofType: .giant)
let wizard = GameCharacterFactory.make(ofType: .wizard)

battle(elf, vs: giant)
battle(wizard, vs: giant)
battle(wizard, vs: elf)
