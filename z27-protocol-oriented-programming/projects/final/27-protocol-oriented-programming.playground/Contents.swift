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

// Introducing Protocol Extensions
extension String {
  func shout() {
    print(uppercased())
  }
}

"Swift is pretty cool".shout()

protocol TeamRecord {
  var wins: Int { get }
  var losses: Int { get }
  var winningPercentage: Double { get }
}

extension TeamRecord {
  var gamesPlayed: Int {
    wins + losses
  }
}

struct BaseballRecord: TeamRecord {
  var wins: Int
  var losses: Int

  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}

let sanFranciscoSwifts = BaseballRecord(wins: 10, losses: 5)
sanFranciscoSwifts.gamesPlayed

// Default Implementations

// Before protocol extension
/*
struct BasketballRecord: TeamRecord {
  var wins: Int
  var losses: Int
  let seasonLength = 82

  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}
*/

extension TeamRecord {
  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}

struct BasketballRecord: TeamRecord {
  var wins: Int
  var losses: Int
  let seasonLength = 82
}

let minneapolisFunctors = BasketballRecord(wins: 60, losses: 22)
minneapolisFunctors.winningPercentage

struct HockeyRecord: TeamRecord {
  var wins: Int
  var losses: Int
  var ties: Int

  // Hockey record introduces ties, and has
  // its own implementation of winningPercentage
  var winningPercentage: Double {
    Double(wins) / Double(wins + losses + ties)
  }
}

// Works with or without ties
let chicagoOptionals = BasketballRecord(wins: 10, losses: 6)
let phoenixStridables = HockeyRecord(wins: 8, losses: 7, ties: 1)

chicagoOptionals.winningPercentage
phoenixStridables.winningPercentage

// Protocol Extension Dispatching
protocol WinLoss {
  var wins: Int { get }
  var losses: Int { get }
}

extension WinLoss {
  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}

struct CricketRecord: WinLoss {
  var wins: Int
  var losses: Int
  var draws: Int

  var winningPercentage: Double {
    Double(wins) / Double(wins + losses + draws)
  }
}

let miamiTuples = CricketRecord(wins: 8, losses: 7, draws: 1)
let winLoss: WinLoss = miamiTuples

miamiTuples.winningPercentage
winLoss.winningPercentage

// Type Constraints
protocol PostSeasonEligible {
  var minimumWinsForPlayoffs: Int { get }
}

extension TeamRecord where Self: PostSeasonEligible {
  var isPlayoffEligible: Bool {
    wins > minimumWinsForPlayoffs
  }
}

protocol Tieable {
  var ties: Int { get }
}

extension TeamRecord where Self: Tieable {
  var winningPercentage: Double {
    Double(wins) / Double(wins + losses + ties)
  }
}

struct RugbyRecord: TeamRecord, Tieable {
  var wins: Int
  var losses: Int
  var ties: Int
}

let rugbyRecord = RugbyRecord(wins: 8, losses: 7, ties: 1)
rugbyRecord.winningPercentage

// Protocol Oriented Benefits
class TeamRecordBase {
  var wins = 0
  var losses = 0

  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}

// Will not compile: inheritance is only possible with classes.
/*
struct BaseballRecord: TeamRecordBase {}
*/

// Inefficent Class Implementation
/*
class HockeyRecord: TeamRecordBase {
  var ties = 0

  override var winningPercentage: Double {
    Double(wins) / Double(wins + losses + ties)
  }
}
 
class TieableRecordBase: TeamRecordBase {
  var ties = 0
 
  override var winningPercentage: Double {
    Double(wins) / Double(wins + losses + ties)
   }
}
 
class HockeyRecord: TieableRecordBase {}
 
class CricketRecord: TieableRecordBase {}
 
extension TieableRecordBase {
  var totalPoints: Int {
    (2 * wins) + (1 * ties)
  }
}
*/

// Traits, mixins, and multiple inheritance
protocol TieableRecord {
  var ties: Int { get }
}

protocol DivisionalRecord {
  var divisionalWins: Int { get }
  var divisionalLosses: Int { get }
}

protocol ScoreableRecord {
  var totalPoints: Int { get }
}

extension ScoreableRecord where Self: TieableRecord, Self: TeamRecord {
  var totalPoints: Int {
    (2 * wins) + (1 * ties)
  }
}

struct NewHockeyRecord: TeamRecord, TieableRecord, DivisionalRecord, CustomStringConvertible, Equatable {
  var wins: Int
  var losses: Int
  var ties: Int
  var divisionalWins: Int
  var divisionalLosses: Int

  var description: String {
    "\(wins) - \(losses) - \(ties)"
  }
}
