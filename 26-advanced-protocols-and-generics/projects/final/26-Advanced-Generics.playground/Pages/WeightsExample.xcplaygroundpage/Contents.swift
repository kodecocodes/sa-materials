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

//protocol WeightCalculatable {
//  associatedtype WeightType
//  var weight: WeightType { get }
//}

class Truck: WeightCalculatable {
  // This heavy truck only needs integer accuracy
  typealias WeightType = Int

  var weight: Int = 100
}

class Flower: WeightCalculatable {
  // This light flower needs decimal places
  typealias WeightType = Double

    var weight: Double = 0.0025
}

//class StringWeightThing: WeightCalculatable {
//  typealias WeightType = String
//
//  var weight: String {
//    "That doesn't make sense"
//  }
//}
//
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

extension WeightCalculatable {
  static func + (left: Self, right: Self) -> WeightType {
    left.weight + right.weight
  }
}

var heavyTruck1 = Truck()
var heavyTruck2 = Truck()
heavyTruck1 + heavyTruck2 // 200

var lightFlower1 = Flower()
//heavyTruck1 + lightFlower1 // the compiler detects your coding error


//var array1: [WeightCalculatable] = [] //error
var trucksList: [Truck] = []
var flowersList: [Flower] = []

class Train: WeightCalculatable {
  typealias WeightType = Int

  var weight: Int {
    9001
  }
}

var heavyList: [Any] = [Truck(), Train()]

class AnyWeightCalculatable<T: Numeric>: WeightCalculatable {
  var weight: T {
    123
  }
}

class Freighter: AnyWeightCalculatable<Int> {
  override var weight: Int {
    200
  }
}

class Cruiser: AnyWeightCalculatable<Int> {
  override var weight: Int {
    9001
  }
}

var heavyList2 = [Freighter(), Cruiser()]
heavyList2.forEach { print($0.weight) }

let array = Array(1...10)
let set = Set(1...10)
let reversedArray = array.reversed()

//let collection = [array, set, reversedArray] //Error

let collections = [AnyCollection(array),
                   AnyCollection(set),
                   AnyCollection(array.reversed())]
