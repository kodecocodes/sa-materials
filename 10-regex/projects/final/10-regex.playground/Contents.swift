/// Copyright (c) 2023 Kodeco LLC
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

//:## Regular Expressions
let searchString = "john"
let searchExpression = /john/

let stringToSearch = "Johnny Appleseed wants to change his name to John."

print(stringToSearch.contains(searchExpression))
print(stringToSearch.contains(searchString))

let flexibleExpression = /[Jj]ohn/
print(stringToSearch.contains(flexibleExpression))

let testingString1 = "abcdef ABCDEF 12345 abc123 ABC 123 123ABC 123abc abcABC"
let lettersAndNumbers = /[a-z]+[0-9]+/

for match in testingString1.matches(of: lettersAndNumbers) {
  print(String(match.output))
}

print("------------------")

let possibleLettersAndPossibleNumbers = /[a-z]*[0-9]*/

for match in testingString1.matches(of: possibleLettersAndPossibleNumbers) {
  print(String(match.output))
}

print("------------------")

let emptyString = ""
let matchCount =  emptyString.matches(of: possibleLettersAndPossibleNumbers).count

let fixedPossibleLettersAndPossibleNumbers = /[a-z]+[0-9]*|[a-z]*[0-9]+/

for match in testingString1.matches(of: fixedPossibleLettersAndPossibleNumbers) {
  print(String(match.output))
}

print("------------------")

let fixedWithBoundaries = /\b[a-z]+[0-9]*\b|\b[a-z]*[0-9]+\b/

for match in testingString1.matches(of: fixedWithBoundaries) {
  print(String(match.output))
}

print("------ Section 2 --------")

import RegexBuilder

let newlettersAndNumbers = Regex {
  OneOrMore {
    "a"..."z"
  }
  OneOrMore {
    CharacterClass.digit
  }
}

for match in testingString1.matches(of: newlettersAndNumbers) {
  print(String(match.output))
}

print("------------------")

let newFixedRegex = Regex {
  Anchor.wordBoundary
  ChoiceOf {
    Regex {
      OneOrMore {
        "a"..."z"
      }
      ZeroOrMore {
        CharacterClass.digit
      }
    }
    Regex {
      ZeroOrMore {
        "a"..."z"
      }
      OneOrMore {
        CharacterClass.digit
      }
    }
  }
  Anchor.wordBoundary
}

for match in testingString1.matches(of: newFixedRegex) {
  print(String(match.output))
}

print("------ Section 3 --------")

let expressionWithCapture = /[a-z]+(\d+)[a-z]+/
let regexWithCapture = Regex {
  OneOrMore {
    "a"..."z"
  }
  TryCapture {
    OneOrMore {
      CharacterClass.digit
    }
  } transform: {foundDigit in
      Int(foundDigit)
    }

  OneOrMore {
    "a"..."z"
  }
}

let testingString2 = "Welc0me to chap7er 10 in sw1ft appren71ce. " +
  "Th1s chap7er c0vers regu1ar express1ons and regexbu1lder"

for match in testingString2.matches(of: regexWithCapture) {
  print(match.output)
}

for match in testingString2.matches(of: regexWithCapture) {
  let (wordMatch, extractedDigit) = match.output
  print("Full Match: \(wordMatch) | Captured value: \(extractedDigit)")
}

let regexWithStrongType = Regex {
  OneOrMore {
    "a"..."z"
  }
  TryCapture {
    OneOrMore {
      CharacterClass.digit
    }
  } transform: {foundDigit in
      Int(foundDigit)
    }

  OneOrMore {
    "a"..."z"
  }
}

for match in testingString2.matches(of: regexWithCapture) {
  print(match.output)
}

print("------------------")

let repetition = "123abc456def789ghi"

let repeatedCaptures = Regex {
  OneOrMore {
    Capture {
      OneOrMore {
        CharacterClass.digit
      }
    }
    OneOrMore {
      "a"..."z"
    }
  }
}

for match in repetition.matches(of: repeatedCaptures) {
  print(match.output)
}



