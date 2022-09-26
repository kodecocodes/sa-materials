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

import Foundation

/*:
 ## Structures
 ### Challenge 1
 Imagine you're at a fruit tree farm and you grow different kinds of fruits: pears, apples, and oranges. After the fruits are picked, a truck brings them in to be processed at the central facility. Since the fruits are all mixed together on the truck, the workers in the central facility have to sort them into the correct inventory container one-by-one.

 Implement an algorithm that receives a truck full of different kinds of fruits and places each fruit into the correct inventory container.
 
 Keep track of the total weight of fruit processed by the facility and print out how many of each fruit are in the inventory.
 */
// All kinds of fruit will share these attributes
struct Fruit {
  let kind: String // e.g. Apple, Pear, Orange
  let weight: Int // measured in grams
}

// Load up the truck full of fruits with random weights
let truck: [Fruit] = [
  Fruit(kind: "Apple", weight: Int.random(in: 70...100)),
  Fruit(kind: "Pear", weight: Int.random(in: 70...100)),
  Fruit(kind: "Apple", weight: Int.random(in: 70...100)),
  Fruit(kind: "Orange", weight: Int.random(in: 70...100)),
  Fruit(kind: "Pear", weight: Int.random(in: 70...100)),
  Fruit(kind: "Apple", weight: Int.random(in: 70...100))
]

// Allocate the inventory containers
var pears = [Fruit]()
var apples = [Fruit]()
var oranges = [Fruit]()

var totalProcessedWeight = 0

// The sorting algorithm accepts a truck full of fruits.
// It processes each fruit independently to
// check what kind of fruit it is and
// place each one into the correct inventory container
func receive(_ truck: [Fruit]) {
  for fruit in truck {
    switch fruit.kind {
    case "Pear":
      pears.append(fruit)
    case "Apple":
      apples.append(fruit)
    case "Orange":
      oranges.append(fruit)
    default:
      fatalError("Fruit type not supported")
    }
    
    totalProcessedWeight += fruit.weight
  }
}

receive(truck)

print("Total weight:", totalProcessedWeight, "grams", "\n---")
print("Quantity of pears:\t\t", pears.count)
print("Quantity of apples:\t\t", apples.count)
print("Quantity of oranges:\t", oranges.count, "\n")
/*:
 ### Challenge 2
 Create a T-shirt structure that has size, color and material options. Provide a method to calculate the cost of a shirt based on its attributes.
 */
 
typealias Size = String
let small: Size = "Small"
let medium: Size = "Medium"
let large: Size = "Large"
let xLarge: Size = "XLarge"

typealias Material = String
let cotton: Material = "Cotton"
let polyester: Material = "Polyester"
let wool: Material = "Wool"

typealias Color = String

/*:
 - Note: Using a floating point number is good for demonstrations, but there are subtle but important reasons why you should not use Floats or Doubles for currency in production. Read about why in this [answer on Stack Overflow](http://stackoverflow.com/questions/3730019/why-not-use-double-or-float-to-represent-currency).
 */

struct TShirt {
  let size: Size
  let color: Color
  let material: Material

  func cost() -> Double {

    let basePrice = 10.0

    let sizeMultiplier: Double
    switch size {
    case small, medium:
      sizeMultiplier = 1.0
    case large, xLarge:
      sizeMultiplier = 1.1
    default:
      // Special order!
      sizeMultiplier = 1.2
    }

    let materialMultipler: Double
    switch material {
    case cotton:
      materialMultipler = 1.0
    case polyester:
      materialMultipler = 1.1
    case wool:
      materialMultipler = 1.5
    default:
      // Special order!
      materialMultipler = 2.0
    }

    return basePrice * sizeMultiplier * materialMultipler
  }
}

TShirt(size: medium, color: "Green", material: cotton).cost() // $10.00
TShirt(size: xLarge, color: "Gray", material: wool).cost() // $16.50



/*:
### Challenge 3
 Write the engine for a Battleship-like game. If you aren’t familiar with Battleship, see here: [http://bit.ly/2nT3JBU](http://bit.ly/2nT3JBU)
 * Use an (x, y) coordinate system for your locations modeled using a structure.
 * Ships should also be modeled with structures. Record an origin, direction and length.
 * Each ship should be able to report if a “shot” has resulted in a “hit”.
*/

struct Coordinate {
  let x: Int
  let y: Int
}

struct Ship {
  let origin: Coordinate
  let direction: String
  let length: Int

  func isHit(coordinate: Coordinate) -> Bool {
    if direction == "Right" {
      return origin.y == coordinate.y &&
             coordinate.x >= origin.x &&
             coordinate.x - origin.x < length
    } else {
      return origin.x == coordinate.x &&
             coordinate.y >= origin.y &&
             coordinate.y - origin.y < length
    }
  }
}

struct Board {

  var ships: [Ship] = []

  func fire(location: Coordinate) -> Bool {
    for ship in ships {
      if ship.isHit(coordinate: location) {
        print("Hit!")
        return true
      }
    }

    return false
  }
}

let patrolBoat = Ship(origin: Coordinate(x: 2, y: 2), direction: "Right", length: 2)
let battleship = Ship(origin: Coordinate(x: 5, y: 3), direction: "Down", length: 4)
let submarine = Ship(origin: Coordinate(x: 0, y: 0), direction: "Down", length: 3)

/*:
  Set up the board.
  */

var board = Board()
board.ships.append(contentsOf: [patrolBoat, battleship, submarine])

/*:
 Play the game.
 */

board.fire(location: Coordinate(x: 2, y: 2)) // Hit on the patrolBoat

board.fire(location: Coordinate(x: 2, y: 3)) // Miss...

board.fire(location: Coordinate(x: 5, y: 6)) // Hit on the battleship

board.fire(location: Coordinate(x: 5, y: 7)) // Miss...
