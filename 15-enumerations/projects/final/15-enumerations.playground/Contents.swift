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
//: ## Chapter 15: Enumerations

let months = ["January", "February", "March", "April", "May",
              "June", "July", "August", "September", "October",
              "November", "December"]

func semester(for month: String) -> String {
  switch month {
  case "August", "September", "October", "November", "December":
    return "Autumn"
  case "January", "February", "March", "April", "May":
    return "Spring"
  default:
    return "Not in the school year"
  }
}

semester(for: "April")

enum Month: Int {
  case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

func semester(for month: Month) -> String {
  switch month {
  case .august, .september, .october, .november, .december:
    return "Autumn"
  case .january, .february, .march, .april, .may:
    return "Spring"
  case .june, .july:
    return "Summer"
  }
}

var month = Month.april
semester(for: month)
month = .september
semester(for: month)


func monthsUntilWinterBreak(from month: Month) -> Int {
  Month.december.rawValue - month.rawValue
}
monthsUntilWinterBreak(from: .april)

let fifthMonth = Month(rawValue: 5)!
monthsUntilWinterBreak(from: fifthMonth)

// 1
enum Icon: String {
  case music
  case sports
  case weather
  var filename: String {
    "\(rawValue).png"
  }
}
let icon = Icon.weather
icon.filename

enum Coin: Int {
  case penny = 1
  case nickel = 5
  case dime = 10
  case quarter = 25
}

let coin = Coin.quarter
coin.rawValue

var balance = 100

enum WithdrawalResult {
  case success(newBalance: Int)
  case error(message: String)
}

func withdraw(amount: Int) -> WithdrawalResult {
  if amount <= balance {
    balance -= amount
    return .success(newBalance: balance)
  } else {
    return .error(message: "Not enough money!")
  }
}

let result = withdraw(amount: 99)

switch result {
case .success(let newBalance):
  print("Your new balance is: \(newBalance)")
case .error(let message):
  print(message)
}

enum HTTPMethod {
  case get
  case post(body: String)
}

let request = HTTPMethod.post(body: "Hi there")
guard case .post(let body) = request else {
  fatalError("No message was posted")
}
print(body)

enum TrafficLight {
  case red, yellow, green
}
let trafficLight = TrafficLight.red

// Looping through all cases

enum Pet: CaseIterable {
  case cat, dog, bird, turtle, fish, hamster
}

for pet in Pet.allCases {
  print(pet)
}

enum Math {
  static func factorial(of number: Int) -> Int {
    (1...number).reduce(1, *)
  }
}
let factorial = Math.factorial(of: 6)

// let math = Math() // ERROR: No accessible initializers

var age: Int?
age = 17
age = nil

switch age {
case .none:
  print("No value")
case .some(let value):
  print("Got a value: \(value)")
}

let optionalNil: Int? = .none
optionalNil == nil    // true
optionalNil == .none  // true
