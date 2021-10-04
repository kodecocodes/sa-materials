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

// -------------------
// | CREATING ARRAYS |
// -------------------

let evenNumbers = [2, 4, 6, 8]

var subscribers: [String] = []

let allZeros = Array(repeating: 0, count: 5)

let vowels = ["A", "E", "I", "O", "U"]

// ----------------------
// | ACCESSING ELEMENTS |
// ----------------------

var players = ["Alice", "Bob", "Cindy", "Dan"]

print(players.isEmpty)
// > false

if players.count < 2 {
  print("We need at least two players!")
} else {
  print("Let's start!")
}
// > Let's start!

var currentPlayer = players.first

print(currentPlayer as Any)
// > Optional("Alice")

print(players.last as Any)
// > Optional("Dan")

currentPlayer = players.min()
print(currentPlayer as Any)
// > Optional("Alice")

print([2, 3, 1].first as Any)
// > Optional(2)
print([2, 3, 1].min() as Any)
// > Optional(1)

if let currentPlayer = currentPlayer {
  print("\(currentPlayer) will start")
}
// > Alice will start

var firstPlayer = players[0]
print("First player is \(firstPlayer)")
// > First player is "Alice"

//var player = players[4]
// > fatal error: Index out of range

let upcomingPlayersSlice = players[1...2]
print(upcomingPlayersSlice[1], upcomingPlayersSlice[2])
// > "Bob Cindy\n"

let upcomingPlayersArray = Array(players[1...2])
print(upcomingPlayersArray[0], upcomingPlayersArray[1])
// > "Bob Cindy\n"


func isEliminated(player: String) -> Bool {
  !players.contains(player)
}

print(isEliminated(player: "Bob"))
// > false

players[1...3].contains("Bob")
// > true

// -------------------------
// | MANIPULATING ELEMENTS |
// -------------------------

players.append("Eli")

players += ["Gina"]

print(players)
// > ["Alice", "Bob", "Cindy", "Dan", "Eli", "Gina"]

players.insert("Frank", at: 5)

// ---------------------
// | REMOVING ELEMENTS |
// ---------------------

var removedPlayer = players.removeLast()
print("\(removedPlayer) was removed")
// > Gina was removed

removedPlayer = players.remove(at: 2)
print("\(removedPlayer) was removed")
// > Cindy was removed

// ---------------------
// | UPDATING ELEMENTS |
// ---------------------

print(players)
// > ["Alice", "Bob", "Dan", "Eli", "Frank"]
players[4] = "Franklin"
print(players)
// > ["Alice", "Bob", "Dan", "Eli", "Franklin"]

players[0...1] = ["Donna", "Craig", "Brian", "Anna"]
print(players)
// > ["Donna", "Craig", "Brian", "Anna", "Dan", "Eli", "Franklin"]

let playerAnna = players.remove(at: 3)
players.insert(playerAnna, at: 0)
print(players)
// > ["Anna", "Donna", "Craig", "Brian", "Dan", "Eli", "Franklin"]

players.swapAt(1, 3)
print(players)
// > ["Anna", "Brian", "Craig", "Donna", "Dan", "Eli", "Franklin"]

players.sort()
print(players)
// > ["Anna", "Brian", "Craig", "Dan", "Donna", "Eli", "Franklin"]


// -------------
// | ITERATION |
// -------------

let scores = [2, 2, 8, 6, 1, 2, 1]

for player in players {
  print(player)
}
// > Anna
// > Brian
// > Craig
// > Dan
// > Donna
// > Eli
// > Franklin

for (index, player) in players.enumerated() {
  print("\(index + 1). \(player)")
}
// > 1. Anna
// > 2. Brian
// > 3. Craig
// > 4. Dan
// > 5. Donna
// > 6. Eli
// > 7. Franklin

func sumOfElements(in array: [Int]) -> Int {
  var sum = 0
  for number in array {
    sum += number
  }
  return sum
}

print(sumOfElements(in: scores))
// > 22
