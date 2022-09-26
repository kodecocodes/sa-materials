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

/*:
 ## Encoding and Decoding Types
 ### Challenge 1
 Given the structures below, make the necessary modifications to make `Spaceship` codable:

 ```swift
 struct Spaceship {
   var name: String
   var crew: [CrewMember]
 }

 struct CrewMember {
   var name: String
   var race: String
 }
```
 */

struct Spaceship: Codable {
  var name: String
  var crew: [CrewMember]
}

struct CrewMember: Codable {
  var name: String
  var race: String
}

/*:
 ### Challenge 2
It appears that the spaceship's interface is different than that of the outpost on Mars. The Mars outpost expects to get the spaceship's name as **spaceship_name**. Make the necessary modifications so encoding the structure would return the JSON in the correct format.
*/

extension Spaceship {
  enum CodingKeys: String, CodingKey {
    case name = "spaceship_name"
    case crew
  }
}

/*:
 ### Challenge 3
 You received a transmission from planet Earth about a new spaceship. This is the incoming message:

 ```
 {"spaceship_name":"USS Enterprise", "captain":{"name":"Spock", "race":"Human"}, "officer":{"name": "Worf", "race":"Klingon"}}
 ```

 Write a custom decoder to convert this JSON into a `Spaceship`.
*/

extension Spaceship {
  /*
   Note that the automatic encoder will always use the `CodingKeys` enum.
   This `CrewKeys` enum is only used by our custom decoder.
   */
  enum CrewKeys: String, CodingKey {
    case captain
    case officer
  }
}

extension Spaceship {
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    let crewValues = try decoder.container(keyedBy: CrewKeys.self)
    let captain = try crewValues.decodeIfPresent(CrewMember.self, forKey: .captain)
    let officer = try crewValues.decodeIfPresent(CrewMember.self, forKey: .officer)
    crew = [captain, officer].compactMap { $0 }
  }
}

let incoming = "{\"spaceship_name\": \"USS Enterprise\", \"captain\":{\"name\":\"Spock\", \"race\":\"Human\"}, \"officer\":{\"name\": \"Worf\", \"race\":\"Klingon\"}}"

let newSpaceship = try JSONDecoder().decode(Spaceship.self, from: incoming.data(using: .utf8)!)

print(newSpaceship)

/*:
 ### Challenge 4
 You intercepted some weird transmissions from the Klingon, which you can't decode. Your scientists were able to discover that
 these transmissions are encoded with a `PropertyListEncoder` and that they're also information of their spaceships. Try your
 luck with writing decoding this message:

 ```
 var klingonSpaceship = Spaceship(name: "IKS NEGH'VAR", crew: [])
 let klingonMessage = try PropertyListEncoder().encode(klingonSpaceship)
 ```
*/

let klingonSpaceship = Spaceship(name: "IKS NEGH'VAR", crew: [])
let klingonMessage = try PropertyListEncoder().encode(klingonSpaceship)

let decodedSpaceship = try PropertyListDecoder().decode(Spaceship.self, from: klingonMessage)
print(decodedSpaceship)

/*:
 The compiler can (as of Swift 5.5) automatically generate codable for enumerations with associated values. Check out how it works by encoding and printing out the following list of items.

 ```swift
 enum Item {
   case message(String)
   case numbers([Int])
   case mixed(String, [Int])
   case person(name: String)
 }

 let items: [Item] = [.message("Hi"),
                      .mixed("Numbers", [1,2]),
                      .person(name: "Kirk"),
                      .message("Bye")]
 ```
 */

enum Item {
  case message(String)
  case numbers([Int])
  case mixed(String, [Int])
  case person(name: String)
}

let items: [Item] = [.message("Hi"),
                     .mixed("Things", [1,2]),
                     .person(name: "Kirk"),
                     .message("Bye")]

extension Item: Codable {}

let data = try JSONEncoder().encode(items)
print("\nEncoded Items:")
print(String(data: data, encoding: .utf8)!)
