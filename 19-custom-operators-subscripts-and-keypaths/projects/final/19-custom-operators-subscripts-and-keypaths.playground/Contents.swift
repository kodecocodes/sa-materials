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

precedencegroup ExponentiationPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

func **<T: BinaryInteger>(base: T, power: Int) -> T {
  precondition(power >= 2)
  var result = base
  for _ in 2...power {
    result *= base
  }
  return result
}

let base = 2
let exponent = 2
let result = base ** exponent

infix operator **=

func **=<T: BinaryInteger>(lhs: inout T, rhs: Int) {
  lhs = lhs ** rhs
}

var number = 2
number **= exponent

let unsignedBase: UInt = 2
let unsignedResult = unsignedBase ** exponent

let base8: Int8 = 2
let result8 = base8 ** exponent

let unsignedBase8: UInt8 = 2
let unsignedResult8 = unsignedBase8 ** exponent

let base16: Int16 = 2
let result16 = base16 ** exponent

let unsignedBase16: UInt16 = 2
let unsignedResult16 = unsignedBase16 ** exponent

let base32: Int32 = 2
let result32 = base32 ** exponent

let unsignedBase32: UInt32 = 2
let unsignedResult32 = unsignedBase32 ** exponent

let base64: Int64 = 2
let result64 = base64 ** exponent

let unsignedBase64: UInt64 = 2
let unsignedResult64 = unsignedBase64 ** exponent

2 * 2 ** 3 ** 2
2 * (2 ** (3 ** 2))

class Person {
  let name: String
  let age: Int
  
  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

let me = Person(name: "Cosmin", age: 36)

extension Person {
  subscript(property key: String) -> String? {
    switch key {
      case "name": return name
      case "age": return "\(age)"
      default: return nil
    }
  }
}

me[property: "name"]
me[property: "age"]
me[property: "gender"]

class File {
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  static subscript(key: String) -> String {
    switch key {
      case "path": return "custom path"
      default: return "default path"
    }
  }
}

File["path"]
File["PATH"]

@dynamicMemberLookup
class Instrument {
  let brand: String
  let year: Int
  private let details: [String: String]
  
  init(brand: String, year: Int, details: [String: String]) {
    self.brand = brand
    self.year = year
    self.details = details
  }
  
  subscript(dynamicMember key: String) -> String {
    switch key {
      case "info": return "\(brand) made in \(year)."
      default: return details[key] ?? ""
    }
  }
}

let instrument = Instrument(brand: "Roland", year: 2021, details: ["type": "acoustic", "pitch": "C"])
instrument.info
instrument.pitch

instrument.brand
instrument.year

class Guitar: Instrument {}
let guitar = Guitar(brand: "Fender", year: 2021, details: ["type": "electric", "pitch": "C"])
guitar.info
guitar.dlfksdf

@dynamicMemberLookup
class Folder {
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  class subscript(dynamicMember key: String) -> String {
    switch key {
      case "path": return "custom path"
      default: return "default path"
    }
  }
}

Folder.path
Folder.PATH

class Tutorial {
  let title: String
  let author: Person
  let details: (type: String, category: String)
  
  init(title: String, author: Person, details: (type: String, category: String)) {
    self.title = title
    self.author = author
    self.details = details
  }
}

let tutorial = Tutorial(title: "Object Oriented Programming in Swift", author: me, details: (type: "Swift", category: "iOS"))

let title = \Tutorial.title
let tutorialTitle = tutorial[keyPath: title]

let authorName = \Tutorial.author.name
var tutorialAuthor = tutorial[keyPath: authorName]

let type = \Tutorial.details.type
let tutorialType = tutorial[keyPath: type]
let category = \Tutorial.details.category
let tutorialCategory = tutorial[keyPath: category]

let authorPath = \Tutorial.author
let authorNamePath = authorPath.appending(path: \.name)
tutorialAuthor = tutorial[keyPath: authorNamePath]

class Jukebox {
  var song: String
  
  init(song: String) {
    self.song = song
  }
}

let jukebox = Jukebox(song: "Nothing Else Matters")

let song = \Jukebox.song
jukebox[keyPath: song] = "Stairway to Heaven"

struct Point {
  let x, y: Int
}

@dynamicMemberLookup
struct Circle {
  let center: Point
  let radius: Int
  
  subscript(dynamicMember keyPath: KeyPath<Point, Int>) -> Int {
    center[keyPath: keyPath]
  }
}

let center = Point(x: 1, y: 2)
let circle = Circle(center: center, radius: 1)
circle.x
circle.y

let anotherTutorial = Tutorial(title: "Encoding and Decoding in Swift", author: me, details: (type: "Swift", category: "iOS"))
let tutorials = [tutorial, anotherTutorial]
let titles = tutorials.map(\.title)



