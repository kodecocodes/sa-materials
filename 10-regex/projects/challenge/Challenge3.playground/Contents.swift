import RegexBuilder

let capsRegex = Regex {
  Anchor.wordBoundary
  ZeroOrMore {
    CharacterClass.digit.union("a"..."z")
  }
  Capture {
    OneOrMore {
      "A"..."Z"
    }
  }
  ZeroOrMore {
    CharacterClass.digit.union("a"..."z")
  }
  Capture {
    ZeroOrMore {
      "A"..."Z"
    }
  }
  ZeroOrMore {
    OneOrMore {
      CharacterClass.digit.union("a"..."z")
    }
    Capture {
      ZeroOrMore {
        "A"..."Z"
      }
    }
  }
  Anchor.wordBoundary
}

let testingString1 = "abcdef ABCDEF 12345 abc123 ABC 123 123ABC 123abc abcABC"

print("Test 1:")

for match in testingString1.matches(of: capsRegex) {
  print(match.output)
}

print("----------------")
print("Test 2:")

let testingString2 = "abcdeABCDE1234 1234ABCDEabcde abcde1234"

for match in testingString2.matches(of: capsRegex) {
  print(match.output)
}

print("----------------")
print("Test 3:")

let testingString3 = "a1b2ABCDEc3d4"

for match in testingString3.matches(of: capsRegex) {
  print(match.output)
}

print("----------------")
print("Test 4:")

let testingString4 = "a1b2ABCDEc3d4FGHe5f6g7"

for match in testingString4.matches(of: capsRegex) {
  print(match.output)
}

print("----------------")
print("Test 5:")

let testingString5 = "a1b2ABCDEc3d4FGHe5f6g7IJK"

for match in testingString5.matches(of: capsRegex) {
  print(match.output)
}

print("----------------")
print("Test 6:")

let testingString6 = "a1b2ABCDEc3d4FGHe5f6g7IJKh8i9LMNj0OPQ"

for match in testingString6.matches(of: capsRegex) {
  print(match.output)
}
