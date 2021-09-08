import UIKit

var greeting = "Hello, playground"

func greet(name: String) -> NSAttributedString {
  let attributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
  let message = NSMutableAttributedString()
  message.append(NSAttributedString(string: "Hello "))
  message.append(NSAttributedString(string: name, attributes: attributes))
  let attributes2 = [
    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
    NSAttributedString.Key.foregroundColor : UIColor.blue
  ]
  message.append(NSAttributedString(string: ", Mother of dragons", attributes: attributes2))
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
    return component ?? NSAttributedString()
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
    return expression
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
    .color(UIColor.red)
  if !title.isEmpty {
    Text(", ")
    Text(title)
      .font(UIFont.systemFont(ofSize: 20))
      .color(UIColor.blue)
  } else {
    Text(", No title")
  }
}

greetBuilder(name: "Daenerys", title: "Mother of dragons")

@AttributedStringBuilder
func greetBuilder(name: String, titles: [String]) -> NSAttributedString {
  Text("Hello ")
  Text(name)
    .color(UIColor.red)
  if !titles.isEmpty {
    for title in titles {
      SpecialCharacters.comma
      SpecialCharacters.lineBreak
      Text(title)
        .font(UIFont.systemFont(ofSize: 20))
        .color(UIColor.blue)
    }
  } else {
    Text(", No title")
  }
}

let titles = ["Khaleesi",
              "Mhysa",
              "The Silver Queen",
              "Silver Lady",
              "The Mother of Dragons"]
greetBuilder(name: "Daenerys", titles: titles)
