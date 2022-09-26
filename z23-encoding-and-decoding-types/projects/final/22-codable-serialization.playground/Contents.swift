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

import Foundation
import XCTest

struct Employee {
  var name: String
  var id: Int
  var favoriteToy: Toy?

  enum CodingKeys: String, CodingKey {
    case id = "employeeId"
    case name
    case gift
  }
}

extension Employee: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encodeIfPresent(favoriteToy?.name, forKey: .gift)
  }
}

extension Employee: Decodable {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    id = try values.decode(Int.self, forKey: .id)
    if let gift = try values.decodeIfPresent(String.self, forKey: .gift) {
      favoriteToy = Toy(name: gift)
    }
  }
}

struct Toy: Codable {
  var name: String
}

let toy1 = Toy(name: "Teddy Bear")
let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee1)
print(jsonData)

let jsonString = String(data: jsonData, encoding: .utf8)!
print(jsonString)

let jsonDecoder = JSONDecoder()
let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)

class EncoderDecoderTests: XCTestCase {
  var jsonEncoder: JSONEncoder!
  var jsonDecoder: JSONDecoder!
  var toy1: Toy!
  var employee1: Employee!

  override func setUp() {
    super.setUp()
    jsonEncoder = JSONEncoder()
    jsonDecoder = JSONDecoder()
    toy1 = Toy(name: "Teddy Bear")
    employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)
  }
  
  func testEncoder() {
    let jsonData = try? jsonEncoder.encode(employee1)
    XCTAssertNotNil(jsonData, "Encoding failed")
    
    let jsonString = String(data: jsonData!, encoding: .utf8)!
    XCTAssertEqual(jsonString, "{\"name\":\"John Appleseed\",\"gift\":\"Teddy Bear\",\"employeeId\":7}")
  }
  
  func testDecoder() {
    let jsonData = try! jsonEncoder.encode(employee1)
    let employee2 = try? jsonDecoder.decode(Employee.self, from: jsonData)
    XCTAssertNotNil(employee2)
    
    XCTAssertEqual(employee1.name, employee2!.name)
    XCTAssertEqual(employee1.id, employee2!.id)
    XCTAssertEqual(employee1.favoriteToy?.name, employee2!.favoriteToy?.name)
  }
}

EncoderDecoderTests.defaultTestSuite.run()
