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

// BASICS
var multiplyClosure = { (a: Int, b: Int) -> Int in
  return a * b
}
let result = multiplyClosure(4, 2)

multiplyClosure = { (a: Int, b: Int) -> Int in
  a * b
}

multiplyClosure = { (a, b) in
  a * b
}

multiplyClosure = {
  $0 * $1
}

func operateOnNumbers(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
  let result = operation(a, b)
  print(result)
  return result
}

let addClosure = { (a: Int, b: Int) in
  a + b
}
operateOnNumbers(4, 2, operation: addClosure)

func addFunction(_ a: Int, _ b: Int) -> Int {
  a + b
}
operateOnNumbers(4, 2, operation: addFunction)

operateOnNumbers(4, 2, operation: { (a: Int, b: Int) -> Int in
  return a + b
})

operateOnNumbers(4, 2, operation: { $0 + $1 })

operateOnNumbers(4, 2, operation: +)

operateOnNumbers(4, 2) {
  $0 + $1
}

func sequenced(first: ()->Void, second: ()->Void) {
  first()
  second()
}

sequenced {
  print("Hello, ", terminator: "")
} second: {
  print("world.")
}

let voidClosure: () -> Void = {
  print("Swift Apprentice is awesome!")
}
voidClosure()

var counter = 0
let incrementCounter = {
  counter += 1
}
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()
incrementCounter()

func countingClosure() -> () -> Int {
  var counter = 0
  let incrementCounter: () -> Int = {
    counter += 1
    return counter
  }
  return incrementCounter
}

let counter1 = countingClosure()
let counter2 = countingClosure()

counter1() // 1
counter2() // 1
counter1() // 2
counter1() // 3
counter2() // 2

// SORTING
let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE"]
names.sorted()

let sortedByLength = names.sorted {
  $0.count > $1.count
}
sortedByLength

// FUNCTIONAL
let values = [1, 2, 3, 4, 5, 6]
values.forEach {
  print("\($0): \($0*$0)")
}

var prices = [1.5, 10, 4.99, 2.30, 8.19]

let largePrices = prices.filter {
  $0 > 5
}

let largePrice = prices.first {
  $0 > 5
}

let salePrices = prices.map {
  $0 * 0.9
}

let userInput = ["0", "11", "haha", "42"]

let numbers1 = userInput.map {
  Int($0)
}

let numbers2 = userInput.compactMap {
  Int($0)
}

let userInputNested = [["0", "1"], ["a", "b", "c"], ["🐕"]]
let allUserInput = userInputNested.flatMap {
  $0
}

let sum = prices.reduce(0) {
  $0 + $1
}

let stock = [1.5: 5, 10: 2, 4.99: 20, 2.30: 5, 8.19: 30]
let stockSum = stock.reduce(0) {
  $0 + $1.key * Double($1.value)
}

let farmAnimals = ["🐎": 5, "🐄": 10, "🐑": 50, "🐶": 1]
let allAnimals = farmAnimals.reduce(into: []) {
  (result, this: (key: String, value: Int)) in
  for _ in 0 ..< this.value {
    result.append(this.key)
  }
}

let removeFirst = prices.dropFirst()
let removeFirstTwo = prices.dropFirst(2)

let removeLast = prices.dropLast()
let removeLastTwo = prices.dropLast(2)

let firstTwo = prices.prefix(2)
let lastTwo = prices.suffix(2)

prices.removeAll() { $0 > 2 }
prices.removeAll()

// LAZY

func isPrime(_ number: Int) -> Bool {
  if number == 1 { return false }
  if number == 2 || number == 3 { return true }

  for i in 2...Int(Double(number).squareRoot()) {
    if number % i == 0 { return false }
  }

  return true
}

var primes: [Int] = []
var i = 1
while primes.count < 10 {
  if isPrime(i) {
    primes.append(i)
  }
  i += 1
}
primes.forEach { print($0) }

let primes2 = (1...).lazy
  .filter { isPrime($0) }
  .prefix(10)
primes2.forEach { print($0) }
