/// Copyright (c) 2020 Razeware LLC
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

import Foundation

protocol Pet {
  var name: String { get }
}

//protocol Pet {
//  associatedtype Food
//  var name: String { get }
//}

struct Cat: Pet {
  var name: String
}

var somePet: Pet = Cat(name: "Whiskers")

//protocol WeightCalculatable {
//  associatedtype WeightType
//  var weight: WeightType { get }
//}

class HeavyThing: WeightCalculatable {
  // This heavy thing only needs integer accuracy
  typealias WeightType = Int

  var weight: Int {
    100
  }
}

class LightThing: WeightCalculatable {
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
//  "That doesn't make sense"
//  }
//}
//
//class CatWeightThing: WeightCalculatable {
//  typealias WeightType = Cat
//
//  var weight: Cat {
//  Cat(name: "What is this cat doing here?")
//  }
//}

protocol WeightCalculatable {
  associatedtype WeightType: Numeric
  var weight: WeightType { get }
}

extension WeightCalculatable {
  static func + (left: Self, right: Self) -> WeightType {
    left.weight + right.weight
  }
}

var heavy1 = HeavyThing()
var heavy2 = HeavyThing()
heavy1 + heavy2 // 200

var light1 = LightThing()
//heavy1 + light1 // the compiler detects your coding error

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
//  var items: [Product] = []
//  productionLines.forEach { items.append($0.produce()) }
//  print("Finished Production")
//  print("-------------------")
//  return items
//  }
//}
//
//struct Car: Product {
//  init() {
//  print("Producing one awesome Car 🚔")
//  }
//}
//
//struct CarProductionLine: ProductionLine {
//  func produce() -> Product {
//  Car()
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
//  print("Producing one chocolate bar 🍫")
//  }
//}
//
//struct ChocolateProductionLine: ProductionLine {
//  func produce() -> Product {
//  Chocolate()
//  }
//}
//
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

struct Car: Product {
  init() {
    print("Producing one awesome Car 🚔")
  }
}

struct Chocolate: Product{
  init() {
    print("Producing one Chocolate bar 🍫")
  }
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

var chocolateFactory = GenericFactory<Chocolate>()
chocolateFactory.productionLines = [GenericProductionLine<Chocolate>(), GenericProductionLine<Chocolate>()]
chocolateFactory.produce()

protocol GraphNode {
  var connectedNodes: [GraphNode] { get set }
}

//protocol Matryoshka {
//  var inside: Matryoshka? { get set }
//}
//
//class HandCraftedMatryoshka: Matryoshka {
//  var inside: Matryoshka?
//}
//
//class MachineCraftedMatryoshka: Matryoshka {
//  var inside: Matryoshka?
//}

protocol Matryoshka: AnyObject {
  var inside: Self? { get set }
}

final class HandCraftedMatryoshka: Matryoshka {
  var inside: HandCraftedMatryoshka?
}

final class MachineCraftedMatryoshka: Matryoshka {
  var inside: MachineCraftedMatryoshka?
}

var handMadeDoll = HandCraftedMatryoshka()
var machineMadeDoll = MachineCraftedMatryoshka()
//handMadeDoll.inside = machineMadeDoll // error

//var array1: [WeightCalculatable] = [] //error
var array2: [HeavyThing] = []
var array3: [LightThing] = []

class VeryHeavyThing: WeightCalculatable {
  typealias WeightType = Int

  var weight: Int {
    9001
  }
}

var heavyList: [Any] = [HeavyThing(), VeryHeavyThing()]

class AnyHeavyThing<T: Numeric>: WeightCalculatable {
  var weight: T {
    123
  }
}

class HeavyThing2: AnyHeavyThing<Int> {
  override var weight: Int {
    100
  }
}

class VeryHeavyThing2: AnyHeavyThing<Int> {
  override var weight: Int {
    9001
  }
}

var heavyList2 = [HeavyThing2(), VeryHeavyThing2()]
heavyList2.forEach { print($0.weight) }

func makeFactory(numberOfLines: Int) -> some Factory {
  var factory = GenericFactory<Car>()
  for _ in 0..<numberOfLines {
    factory.productionLines.append(GenericProductionLine<Car>())
  }
  return factory
}

func makeEquatableNumeric() -> some Numeric & Equatable {
  return 1
}

let someVar = makeEquatableNumeric()
let someVar2 = makeEquatableNumeric()

print(someVar == someVar2)
print(someVar + someVar2)
//print(someVar > someVar2) // error
