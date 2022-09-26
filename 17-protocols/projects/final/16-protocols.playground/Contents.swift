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

//: ## Protocols

//: ### Protocol syntax

protocol Vehicle {
  func accelerate()
  func stop()
}

class Unicycle: Vehicle {
  var peddling = false
    
  func accelerate() {
    peddling = true
  }
    
  func stop() {
    peddling = false
  }
}

enum Direction {
  case left
  case right
}

protocol DirectionalVehicle {
  func accelerate()
  func stop()
  func turn(_ direction: Direction)
  func description() -> String
}

protocol OptionalDirectionVehicle {
  func turn()
  func turn(_ direction: Direction)
}

protocol VehicleProperties {
  var weight: Int {get}
  var name: String { get set }
}

protocol Account {
  var value: Double { get set }
  init(initialAmount: Double)
  init?(transferAccount: Account)
}

class BitcoinAccount: Account {
  var value: Double
    
  required init(initialAmount: Double) {
    value = initialAmount
  }
    
  required init?(transferAccount: Account) {
    guard transferAccount.value > 0.0 else {
      return nil
    }
    value = transferAccount.value
  }
}

var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)!

protocol WheeledVehicle: Vehicle {
  var numberOfWheels: Int { get }
  var wheelSize: Double { get set }
}

//class Bike: Vehicle {
//  var peddling = false
//  var brakesApplied = false
//
//  func accelerate() {
//    peddling = true
//    brakesApplied = false
//  }
//
//  func stop() {
//    peddling = false
//    brakesApplied = true
//  }
//}

//class Bike: WheeledVehicle {
//
//  let numberOfWheels = 2
//  var wheelSize = 16.0
//
//  var peddling = false
//  var brakesApplied = false
//
//  func accelerate() {
//    peddling = true
//    brakesApplied = false
//  }
//
//  func stop() {
//    peddling = false
//    brakesApplied = true
//  }
//}

protocol WeightCalculatable {
  associatedtype WeightType
  var weight: WeightType { get }
}

class HeavyThing: WeightCalculatable {
  // This heavy thing only needs integer accuracy
  typealias WeightType = Int
  
  var weight: Int { 100 }
}

class LightThing: WeightCalculatable {
  // This light thing needs decimal places
  typealias WeightType = Double
  
  var weight: Double { 0.0025 }
}

// Error!
// let weightedThing: WeightCalculatable = LightThing()

protocol Wheeled {
  var numberOfWheels: Int { get }
  var wheelSize: Double { get set }
}

class Bike: Vehicle, Wheeled {

  let numberOfWheels = 2
  var wheelSize = 16.0

  var peddling = false
  var brakesApplied = false

  func accelerate() {
    peddling = true
    brakesApplied = false
  }

  func stop() {
    peddling = false
    brakesApplied = true
  }
}

func roundAndRound(transportation: Vehicle & Wheeled) {
  transportation.stop()
  print("The brakes are being applied to \(transportation.numberOfWheels) wheels.")
}

roundAndRound(transportation: Bike())

protocol Reflective {
  var typeName: String { get }
}

extension String: Reflective {
  var typeName: String {
    "I'm a String"
  }
}

let title = "Swift Apprentice!"
title.typeName

class AnotherBike: Wheeled {
  var peddling = false
  let numberOfWheels = 2
  var wheelSize = 16.0
}

extension AnotherBike: Vehicle {
  func accelerate() {
    peddling = true
  }
    
  func stop() {
    peddling = false
  }
}

protocol Named {
  var name: String { get set }
}

class ClassyName: Named {
  var name: String

  init(name: String) {
   self.name = name
  }
}

struct StructyName: Named {
  var name: String
}

var named: Named = ClassyName(name: "Classy")
var copy = named

named.name = "Still Classy"
named.name
copy.name

named = StructyName(name: "Structy")
copy = named

named.name = "Still Structy?"
named.name
copy.name

extension Student: Identifiable {
  var id: String {
    email
  }
}

//protocol Named: AnyObject {
//  var name: String { get set }
//}

let a = 5
let b = 5

a == b

let swiftA = "Swift"
let swiftB = "Swift"

swiftA == swiftB

class Record {
  var wins: Int
  var losses: Int
    
  init(wins: Int, losses: Int) {
    self.wins = wins
    self.losses = losses
  }
}

let recordA = Record(wins: 10, losses: 5)
let recordB = Record(wins: 10, losses: 5)

extension Record: Equatable {
  static func ==(lhs: Record, rhs: Record) -> Bool {
    lhs.wins == rhs.wins &&
    lhs.losses == rhs.losses
  }
}

recordA == recordB

extension Record: Comparable {
  static func <(lhs: Record, rhs: Record) -> Bool {
    if lhs.wins == rhs.wins {
      return lhs.losses > rhs.losses
    }
    return lhs.wins < rhs.wins
  }
}

let teamA = Record(wins: 14, losses: 11)
let teamB = Record(wins: 23, losses: 8)
let teamC = Record(wins: 23, losses: 9)
var leagueRecords = [teamA, teamB, teamC]

leagueRecords.sort()
leagueRecords.max()
leagueRecords.min()
leagueRecords.starts(with: [teamA, teamC])
leagueRecords.contains(teamA)

class Student {
  let email: String
  let firstName: String
  let lastName: String
  weak var buddy: Student?
    
  init(email: String, firstName: String, lastName: String) {
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
  }
}

extension Student: Hashable {
  static func ==(lhs: Student, rhs: Student) -> Bool {
    lhs.email == rhs.email &&
    lhs.firstName == rhs.firstName &&
    lhs.lastName == rhs.lastName
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(email)
    hasher.combine(firstName)
    hasher.combine(lastName)
  }
}

let john = Student(email: "johnny.appleseed@apple.com", firstName: "Johnny", lastName: "Appleseed")
let lockerMap = [john: "14B"]

extension Student: CustomStringConvertible {
  var description: String {
    "\(firstName) \(lastName)"
  }
}

print(john)
