let capsRegex = /\b[a-z0-9]*[A-Z]+[a-z0-9]*\b/

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
