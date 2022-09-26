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
/*:
 ## Challenge 1: Robot vehicle builder
 Using protocols, define a robot that makes vehicle toys.
 * Each robot is able to assemble a different number of pieces per minute. For example, Robot-A can assemble ten pieces per minute, while Robot-B can assemble five.
 * Each robot type is only able to build a single type of toy.
 * Each toy type has a price value.
 * Each toy type has a different number of pieces. You tell the robot how long it should operate and it will provide the finished toys.
 * Add a method to tell the robot how many toys to build. It will build them and say how much time it needed.
 */

protocol VehicleToy {
  static var numberOfPieces: Int { get }
  init()
}

protocol Robot {
  associatedtype ToyType where ToyType: VehicleToy
  var piecesPerMinute: Int { get }

  func operate(durationInMinutes: Int) -> [ToyType]
  func operate(newItems: Int) -> (Int, [ToyType])
}

extension Robot {
  func operate(newItems: Int) -> (Int, [ToyType]) {
    let totalPieces = newItems * ToyType.numberOfPieces
    let operationTime = totalPieces / piecesPerMinute

    var newToys: [ToyType] = []
    for _ in 0..<newItems {
      newToys.append(ToyType())
    }

    return (operationTime, newToys)
  }

  func operate(durationInMinutes: Int) -> [ToyType] {
    let numberOfToys = (durationInMinutes * piecesPerMinute) / ToyType.numberOfPieces
    return operate(newItems: numberOfToys).1
  }
}

/*:
 ## Challenge 2: Toy Train Builder
 Declare a function that constructs robots that make toy trains.
 * A train has 75 Pieces.
 * A train robot can assemble 500 pieces per minute.
 * Use an opaque return type to hide the type of robot you return.
 */

struct TrainToy: VehicleToy {
  static var numberOfPieces = 75
}

struct TrainRobot: Robot {
  var piecesPerMinute = 500
  typealias ToyType = TrainToy
}

func makeToyBuilder() -> some Robot {
  TrainRobot()
}

/*:
 ## Challenge 3: Monster truck toy
 Create a monster truck toy that has 120 pieces and a robot to make this toy. The robot is less sophisticated and can only assemble 200 pieces per minute. Next, change the `makeToyBuilder()` function to return this new robot.
 */

struct MonsterTruckToy: VehicleToy {
  static var numberOfPieces = 120
}

struct MonsterTruckRobot: Robot {
  var piecesPerMinute = 200
  typealias ToyType = TrainToy
}

//func makeToyBuilder() -> some Robot {
//  MonsterTruckRobot()
//}


/*:
 ## Challenge 4: Shop Robot
 Define a shop that uses a robot to make the toy that this shop will be selling.
 * This shop should have two inventories: a display and a warehouse.
 * There is a limit to the number of items on the display, but there is no limit on the warehouse size.
 * In the morning of every day the display is filled from the warehouse.
 * For each coming customer an average of 1.5 toys are sold.
 * To reduce the running costs of the operations, the robot is set to only work when the contents of the warehouse is less than the size of the inventory. And the size of the inventory should not be more than twice the size of the display.
 * The shop has a `startDay(numberOfVisitors: Int)` method. This will fist fill the display from the inventory.
 * Sell items from the display based on the number of customers.
 * If the shop needs the robot, rent the robot and operate it for the duration required.
 */

class Shop {
  var displayList: [VehicleToy] = []
  var warehouseList: [VehicleToy] = []
  let displaySize = 100

  private func fillDisplay() {
    if displayList.count < displaySize {
      var difference = displaySize - displayList.count
      if difference > warehouseList.count {
        difference = warehouseList.count
      }

      let itemsToAdd = warehouseList[0..<difference]
      displayList.append(contentsOf: itemsToAdd)
      warehouseList.removeFirst(difference)
    }
  }

  private func shipToys(count: Int) -> Int {
    let actualSales = count > displayList.count ? displayList.count : count
    displayList.removeFirst(actualSales)

    return actualSales
  }

  func startDay(numberOfVisitors: Int) {

    fillDisplay()

    let potentialSales = Double(numberOfVisitors) * 1.5
    let actualSales = shipToys(count: Int(potentialSales))

    print("Potential sales today were: \(potentialSales)")
    print("Actual sales today were: \(actualSales)")

    print("Current warehouse has \(warehouseList.count) items")
    print("Current display has \(displayList.count) items")

    if warehouseList.count < displaySize {
      let itemsToConstruct = (displaySize * 2) - warehouseList.count
      let robot = makeToyBuilder()
      let (operationalDuration, newItems) = robot.operate(newItems: itemsToConstruct)

      warehouseList.append(contentsOf: newItems)

      print("Robot was rented today and operated for: \(operationalDuration) minutes")
    }else {
      print("Robot was not needed today")
    }

    print("-------- End of Day --------")
  }
}


let shop = Shop()

shop.startDay(numberOfVisitors: 50)

shop.startDay(numberOfVisitors: 100)

shop.startDay(numberOfVisitors: 10)

shop.startDay(numberOfVisitors: 5)
