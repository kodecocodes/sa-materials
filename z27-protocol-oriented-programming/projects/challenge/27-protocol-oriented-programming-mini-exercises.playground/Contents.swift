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
 Write a default implementation on `CustomStringConvertible` that will simply remind you to implement `description` by returning `Remember to implement CustomStringConvertible!`.

 In other words, once you have your default implementation, you should be able to write code like this:

struct MyStruct: CustomStringConvertible {}
print(MyStruct())
// should print "Remember to implement CustomStringConvertible!"
 */
extension CustomStringConvertible {
  var description: String {
    "Remember to implement CustomStringConvertible!"
  }
}

struct MyStruct: CustomStringConvertible { }
print(MyStruct())
/*:
 Write a default implementation on `CustomStringConvertible` that will print the win/loss record in the format `Wins - Losses` for any `TeamRecord` type. For instance, if a team is 10 and 5, it should return `10 - 5`.
 */
protocol TeamRecord {
  var wins: Int { get }
  var losses: Int { get }
  var winningPercentage: Double { get }
}


extension CustomStringConvertible where Self: TeamRecord {
  var description: String {
    "\(wins) - \(losses)"
  }
}

struct BaseballRecord: TeamRecord {
  var wins: Int
  var losses: Int

  var winningPercentage: Double {
    Double(wins) / Double(wins + losses)
  }
}

extension BaseballRecord: CustomStringConvertible { }

print(BaseballRecord(wins: 4, losses: 2))
