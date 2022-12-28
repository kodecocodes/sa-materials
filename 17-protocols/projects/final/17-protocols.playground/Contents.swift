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

//: ## Protocols

protocol Vehicle {
  /// Return a description of the state of the vehicle.
  func describe() -> String

  /// Increases speed until it reaches its maximum speed.
  mutating func accelerate()

  /// Stop moving. Reducing the speed to zero miles per hour.
  mutating func stop()
  
  /// The speed of the vehicle in miles per hour.
  var speed: Double { get set }

  /// The maximum speed attainable by this Vehicle type.
  static var maxSpeed: Double { get }
}

class Unicycle: Vehicle {
  func describe() -> String {
    "Unicycle @ \(speed) mph"
  }
  func accelerate() {
    speed = min(speed + 2, Self.maxSpeed)
  }
//  func stop() {
//    speed = 0
//  }
  var speed: Double = 0
  static var maxSpeed: Double { 15 }
}

struct Car {
  func describe() -> String {
    "Car @ \(speed) mph"
  }
  mutating func accelerate() {
    speed = min(speed + 20, Self.maxSpeed)
  }
//  mutating func stop() {
//    speed = 0
//  }
  var speed: Double = 0
  static var maxSpeed: Double { 150 }
}

extension Car: Vehicle {}

extension Vehicle {
  mutating func stop() {
    speed = 0
  }
}

extension Vehicle {
  /// Return the speed as a value between 0-1.
  var normalizedSpeed: Double {
    speed / Self.maxSpeed
  }
}

enum BrakePressure {
  case light
  case normal
  case hard
}

protocol Braking {
  /// Apply the brakes.
  mutating func brake(_ pressure: BrakePressure)
}

extension Braking {
  /// Apply normal brakes.
  mutating func brake() {
    brake(.normal)
  }
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

let accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)!

protocol WheeledVehicle: Vehicle {
  var numberOfWheels: Int { get }
  var wheelSize: Double { get }
}

extension Unicycle: WheeledVehicle {
  var numberOfWheels: Int { 1 }
  var wheelSize: Double { 20.0 }
}

func stop(vehicles: inout [any Vehicle]) {
  vehicles.indices.forEach {
    vehicles[$0].stop()
  }
}

protocol Wheeled {
  var numberOfWheels: Int { get }
  var wheelSize: Double { get }
}

extension Car: Wheeled {
  var numberOfWheels: Int { 4 }
  var wheelSize: Double { 17 }
}

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

let weightedThing: any WeightCalculatable = LightThing()

// func freeze(transportation: inout any Vehicle & Wheeled)
func freeze(transportation: inout some Vehicle & Wheeled) {
    transportation.stop()
    print("Stopping the rotation of \(transportation.numberOfWheels) wheel(s).")
}

var car = Car()
freeze(transportation: &car)

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
