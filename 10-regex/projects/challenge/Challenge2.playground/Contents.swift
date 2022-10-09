import RegexBuilder

let capsRegex = Regex {
  Anchor.wordBoundary
  OneOrMore {
    ZeroOrMore {
      CharacterClass.digit.union("a"..."z")
    }
    OneOrMore {
      "A"..."Z"
    }
    ZeroOrMore {
      CharacterClass.digit.union("a"..."z")
    }
  }
  Anchor.wordBoundary
}

let testingString1 = "abcdef ABCDEF 12345 abc123 ABC 123 123ABC 123abc abcABC"

print("Test 1:")

for match in testingString1.matches(of: capsRegex) {
    print(String(match.output))
}

print("----------------")
print("Test 2:")

let testingString2 = "abcdeABCDE1234 1234ABCDEabcde abcde1234"

for match in testingString2.matches(of: capsRegex) {
    print(String(match.output))
}

print("----------------")
print("Test 3:")

let testingString3 = "a1b2ABCDEc3d4"

for match in testingString3.matches(of: capsRegex) {
    print(String(match.output))
}

print("----------------")
print("Test 4:")

let testingString4 = "a1b2ABCDEc3d4FGHe5f6g7"

for match in testingString4.matches(of: capsRegex) {
    print(String(match.output))
}
