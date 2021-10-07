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

import UIKit

func greet(name: String) -> NSAttributedString {
  let attributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
  let message = NSMutableAttributedString()
  message.append(NSAttributedString(string: "Hello "))
  message.append(NSAttributedString(string: name, attributes: attributes))
  let attributes2 = [
    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
    NSAttributedString.Key.foregroundColor : UIColor.blue
  ]
  message.append(NSAttributedString(string: ", Mother of Dragons", attributes: attributes2))
  return message
}

greet(name: "Daenerys")


@resultBuilder
enum AttributedStringBuilder {
  static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
    let attributedString = NSMutableAttributedString()
    for component in components {
      attributedString.append(component)
    }
    return attributedString
  }

  static func buildOptional(_ component: NSAttributedString?) -> NSAttributedString {
    component ?? NSAttributedString()
  }

  static func buildEither(first component: NSAttributedString) -> NSAttributedString {
    component
  }

  static func buildEither(second component: NSAttributedString) -> NSAttributedString {
    component
  }

  static func buildArray(_ components: [NSAttributedString]) -> NSAttributedString {
    let attributedString = NSMutableAttributedString()
    for component in components {
      attributedString.append(component)
    }
    return attributedString
  }

  static func buildExpression(_ expression: SpecialCharacters) -> NSAttributedString {
    switch expression {
    case .lineBreak:
      return Text("\n")
    case .comma:
      return Text(",")
    }
  }

  static func buildExpression(_ expression: NSAttributedString) -> NSAttributedString {
    expression
  }
}

enum SpecialCharacters {
  case lineBreak
  case comma
}

typealias Text = NSMutableAttributedString

extension NSMutableAttributedString {
  public func color(_ color : UIColor) -> NSMutableAttributedString {
    self.addAttribute(NSAttributedString.Key.foregroundColor,
                      value: color,
                      range: NSRange(location: 0, length: self.length))
    return self
  }

  public func font(_ font : UIFont) -> NSMutableAttributedString {
    self.addAttribute(NSAttributedString.Key.font,
                      value: font,
                      range: NSRange(location: 0, length: self.length))
    return self
  }

  convenience init(_ string: String) {
    self.init(string: string)
  }
}

@AttributedStringBuilder
func greetBuilder(name: String, title: String) -> NSAttributedString {
  Text("Hello ")
  Text(name)
    .color(.red)
  if !title.isEmpty {
    Text(", ")
    Text(title)
      .font(.systemFont(ofSize: 20))
      .color(.blue)
  } else {
    Text(", No title")
  }
}

greetBuilder(name: "Daenerys", title: "Mother of Dragons")

@AttributedStringBuilder
func greetBuilder(name: String, titles: [String]) -> NSAttributedString {
  Text("Hello ")
  Text(name)
    .color(.red)
  if !titles.isEmpty {
    for title in titles {
      SpecialCharacters.comma
      SpecialCharacters.lineBreak
      Text(title)
        .font(.systemFont(ofSize: 20))
        .color(.blue)
    }
  } else {
    Text(", No title")
  }
}

let titles = ["Khaleesi",
              "Mhysa",
              "First of Her Name",
              "Silver Lady",
              "The Mother of Dragons"]
greetBuilder(name: "Daenerys", titles: titles)
