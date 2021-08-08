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

// STRINGS AS COLLECTIONS
let string = "Matt"
for char in string {
  print(char)
}

let stringLength = string.count
//let fourthChar = string[3] // error: 'subscript' is unavailable: cannot subscript String with an Int, see the documentation comment for discussion


// GRAPHEME CLUSTERS
let cafeNormal = "café"
let cafeCombining = "cafe\u{0301}"

cafeNormal.count
cafeCombining.count

cafeNormal.unicodeScalars.count
cafeCombining.unicodeScalars.count

for codePoint in cafeCombining.unicodeScalars {
  print(codePoint.value)
}


// INDEXING STRINGS
let firstIndex = cafeCombining.startIndex
let firstChar = cafeCombining[firstIndex]

//let lastIndex = cafeCombining.endIndex
let lastIndex = cafeCombining.index(before: cafeCombining.endIndex)
let lastChar = cafeCombining[lastIndex]

let fourthIndex = cafeCombining.index(cafeCombining.startIndex, offsetBy: 3)
let fourthChar = cafeCombining[fourthIndex]

fourthChar.unicodeScalars.count
fourthChar.unicodeScalars.forEach { codePoint in
  print(codePoint.value)
}


// EQUALITY WITH COMBINING CHARACTERS
let equal = cafeNormal == cafeCombining


// STRINGS AS BIDIRECTIONAL COLLECTIONS
let name = "Matt"
let backwardsName = name.reversed()
let secondCharIndex = backwardsName.index(backwardsName.startIndex, offsetBy: 1)
let secondChar = backwardsName[secondCharIndex]

let backwardsNameString = String(backwardsName)


// RAW STRINGS

let raw1 = #"Raw "No Escaping" \(no interpolation!). Use all the \ you want!"#
print(raw1)

let raw2 = ##"Aren't we "# clever"##
print(raw2)

let can = "can do that too"
let raw3 = #"Yes we \#(can)!"#
print(raw3)

let multiRaw = #"""
  _____         _  __ _                                         _   _
 / ____|       (_)/ _| |       /\                              | | (_)
| (_____      ___| |_| |_     /  \   _ __  _ __  _ __ ___ _ __ | |_ _  ___ ___
 \___ \ \ /\ / / |  _| __|   / /\ \ | '_ \| '_ \| '__/ _ \ '_ \| __| |/ __/ _ \
 ____) \ V  V /| | | | |_   / ____ \| |_) | |_) | | |  __/ | | | |_| | (_|  __/
|_____/ \_/\_/ |_|_|  \__| /_/    \_\ .__/| .__/|_|  \___|_| |_|\__|_|\___\___|
                                  | |   | |
                                  |_|   |_|
"""#
print(multiRaw)

// SUBSTRINGS
let fullName = "Matt Galloway"
let spaceIndex = fullName.firstIndex(of: " ")!
let firstName = fullName[..<spaceIndex]
let lastName = fullName[fullName.index(after: spaceIndex)...]
let lastNameString = String(lastName)


// CHARACTER PROPERTIES
let singleCharacter: Character = "x"
singleCharacter.isASCII

let space: Character = " "
space.isWhitespace

let hexDigit: Character = "d"
hexDigit.isHexDigit

let thaiNine: Character = "๙"
thaiNine.wholeNumberValue


// ENCODING
let char = "\u{00bd}"
for i in char.utf8 {
  print(i)
}

let characters = "+\u{00bd}\u{21e8}\u{1f643}"
for i in characters.utf8 {
  print("\(i) : \(String(i, radix: 2))")
}
for i in characters.utf16 {
  print("\(i) : \(String(i, radix: 2))")
}

let arrowIndex = characters.firstIndex(of: "\u{21e8}")!
characters[arrowIndex]

if let unicodeScalarsIndex = arrowIndex.samePosition(in: characters.unicodeScalars) {
  characters.unicodeScalars[unicodeScalarsIndex]
}

if let utf8Index = arrowIndex.samePosition(in: characters.utf8) {
  characters.utf8[utf8Index]
}

if let utf16Index = arrowIndex.samePosition(in: characters.utf16) {
  characters.utf16[utf16Index]
}
