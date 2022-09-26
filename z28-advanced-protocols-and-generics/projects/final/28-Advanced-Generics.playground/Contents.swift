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

//protocol Pet {
//  var name: String { get }
//}
//struct Cat: Pet {
//  var name: String
//}
//
//var somePet: Pet = Cat(name: "Whiskers")

//protocol Pet {
//  associatedtype Food
//  var name: String { get }
//}

//protocol WeightCalculatable {
//  associatedtype WeightType
//  var weight: WeightType { get }
//}

class Truck: WeightCalculatable {
  // This heavy thing only needs integer accuracy
  typealias WeightType = Int

  var weight: Int {
    100
  }
}

class Flower: WeightCalculatable {
  // This light thing needs decimal places
  typealias WeightType = Double

  var weight: Double {
    0.0025
  }
}

//class StringWeightThing: WeightCalculatable {
//  typealias WeightType = String
//
//  var weight: String {
//    "That doesn't make sense"
//  }
//}

//class CatWeightThing: WeightCalculatable {
//  typealias WeightType = Cat
//
//  var weight: Cat {
//    Cat(name: "What is this cat doing here?")
//  }
//}

protocol WeightCalculatable {
  associatedtype WeightType: Numeric
  var weight: WeightType { get }
}

//protocol Product {}
//
//protocol ProductionLine  {
//  func produce() -> Product
//}
//
//protocol Factory {
//  var productionLines: [ProductionLine] {get}
//}
//
//extension Factory {
//  func produce() -> [Product] {
//    var items: [Product] = []
//    productionLines.forEach { items.append($0.produce()) }
//    print("Finished Production")
//    print("-------------------")
//    return items
//  }
//}
//


struct Car: Product {
  init() {
    print("Producing one awesome Car 🚔")
  }
}
//
//struct CarProductionLine: ProductionLine {
//  func produce() -> Product {
//    Car()
//  }
//}
//
//struct CarFactory: Factory {
//  var productionLines: [ProductionLine] = []
//}
//
//var carFactory = CarFactory()
//carFactory.productionLines = [CarProductionLine(), CarProductionLine()]
//carFactory.produce()
//
//struct Chocolate: Product {
//  init() {
//    print("Producing one chocolate bar 🍫")
//  }
//}
//
//struct ChocolateProductionLine: ProductionLine {
//  func produce() -> Product {
//    Chocolate()
//  }
//}

//var oddCarFactory = CarFactory()
//oddCarFactory.productionLines = [CarProductionLine(), ChocolateProductionLine()]
//oddCarFactory.produce()

protocol Product {
  init()
}

protocol ProductionLine {
  associatedtype ProductType
  func produce() -> ProductType
}

protocol Factory {
  associatedtype ProductType
  func produce() -> [ProductType]
}

struct GenericProductionLine<P: Product>: ProductionLine {
  func produce() -> P {
    P()
  }
}

struct GenericFactory<P: Product>: Factory {
  var productionLines: [GenericProductionLine<P>] = []

  func produce() -> [P] {
    var newItems: [P] = []
    productionLines.forEach { newItems.append($0.produce()) }
    print("Finished Production")
    print("-------------------")
    return newItems
  }
}

var carFactory = GenericFactory<Car>()
carFactory.productionLines = [GenericProductionLine<Car>(), GenericProductionLine<Car>()]
carFactory.produce()

// MARK: -

let array = Array(1...10)
let set = Set(1...10)
let reversedArray = array.reversed()

for e in reversedArray {
 print(e)
}

let arrayCollections = [array, Array(set), Array(reversedArray)]

let collections = [AnyCollection(array),
                   AnyCollection(set),
                   AnyCollection(array.reversed())]

let total = collections.flatMap { $0 }.reduce(0, +) // 165

protocol Pet {
  associatedtype Food
  func eat(_ food: Food)
}

enum PetFood { case dry, wet }

struct Cat: Pet {
  func eat(_ food: PetFood) {
    print("Eating cat food.")
  }
}

struct Dog: Pet {
  func eat(_ food: PetFood) {
    print("Eating dog food.")
  }
}

//let pets: [Pet] = [Dog(), Cat()] // ERROR: Pet can only be used as a generic constraint

struct AnyPet<Food>: Pet {
  private let _eat: (Food) -> Void

  init<SomePet: Pet>(_ pet: SomePet) where SomePet.Food == Food {
    _eat = pet.eat(_:)
  }

  func eat(_ food: Food) {
    _eat(food)
  }
}

let pets = [AnyPet(Dog()), AnyPet(Cat())]

extension Pet {
  func eraseToAnyPet() -> AnyPet<Food> {
    .init(self)
  }
}

let morePets = [Dog().eraseToAnyPet(),
            Cat().eraseToAnyPet()]

func makeValue() -> some FixedWidthInteger {
  42
}

print("Two makeVales summed", makeValue() + makeValue())

func makeValueRandomly() -> some FixedWidthInteger {
  if Bool.random() {
    return Int(42)
  }
  else {
    // return Int8(24) // Compiler error.  All paths must return same type.
    return Int(24)
  }
}

// let v: FixedWidthInteger = 42 // compiler error
let v = makeValue() // works

func makeEquatableNumericInt() -> some Numeric & Equatable { 1 }
func makeEquatableNumericDouble() -> some Numeric & Equatable { 1.0 }

let value1 = makeEquatableNumericInt()
let value2 = makeEquatableNumericInt()

print(value1 == value2) // prints true
print(value1 + value2) // prints 2
// print(value1 > value2) // error

// Compiler error, types don't match up
// makeEquatableNumericInt() == makeEquatableNumericDouble()
