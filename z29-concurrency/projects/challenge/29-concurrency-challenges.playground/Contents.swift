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

import SwiftUI
/*:
 ## Concurrency
 ### Challenge 1: Safe teams
 Change the following class so it's asynchronous-safe:
 
 ```swift
 class Team {
   let name: String
   let stadium: String
   private var players: [String]
 
   init(name: String, stadium: String, players: [String]) {
     self.name = name
     self.stadium = stadium
     self.players = players
   }
 
   private func add(player: String) {
     players.append(player)
   }
 
   private func remove(player: String) {
     guard !players.isEmpty, let index = players.firstIndex(of: player) else {return}
     players.remove(at: index)
   }
 
   func buy(player: String, from team: Team) {
     team.remove(player: player)
     add(player: player)
   }
 
   func sell(player: String, to team: Team) {
     team.add(player: player)
     remove(player: player)
   }
 }
 ```
 */
actor Team {
  let name: String
  let stadium: String
  private var players: [String]
  
  init(name: String, stadium: String, players: [String]) {
    self.name = name
    self.stadium = stadium
    self.players = players
  }
  
  private func add(player: String) {
    players.append(player)
  }
  
  private func remove(player: String) {
    guard !players.isEmpty, let index = players.firstIndex(of: player) else {return}
    players.remove(at: index)
  }
  
  func buy(player: String, from team: Team) async {
    await team.remove(player: player)
    add(player: player)
  }
  
  func sell(player: String, to team: Team) async {
    await team.add(player: player)
    remove(player: player)
  }
}

let madridTeam = Team(name: "Real Madrid", stadium: "Santiago Bernabeu", players: ["Lionel Messi"])
let barcelonaTeam = Team(name: "FC Barcelona" , stadium: "Camp Nou", players: ["Cristiano Ronaldo"])

Task {
  await madridTeam.buy(player: "Cristiano Ronaldo", from: barcelonaTeam)
  await madridTeam.sell(player: "Lionel Messi", to: barcelonaTeam)
}
/*:
 ### Challenge 2: Custom teams
 Conform the asynchronous-safe type from the previous challenge to `CustomStringConvertible`.
 */
extension Team: CustomStringConvertible {
  nonisolated var description: String  {
    "\(name) plays at \(stadium)."
  }
}

print(madridTeam)
/*:
 ### Challenge 3: `Sendable` teams
 Make the following class `Sendable`:
 
 ```swift
 class BasicTeam {
   var name: String
   var stadium: String
 
   init(name: String, stadium: String) {
     self.name = name
     self.stadium = stadium
   }
 }
 ```
 */
final class BasicTeam {
  let name: String
  let stadium: String
  
  init(name: String, stadium: String) {
    self.name = name
    self.stadium = stadium
  }
}

extension BasicTeam: Sendable {}
