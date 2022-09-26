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
 ## Enumerations Challenge Set 2
 
 Taking the example from earlier in the chapter, begin with the `Month` enumeration:
 
 ```swift
 /// enum Month: Int {
 ///   case january = 1, february, march, april, may, june, july, august, september, october, november, december
 /// }
 ```
 
 Write a computed property to calculate the number of months until summer.
 
 **Hint:** You’ll need to account for a negative value if summer has already passed in the current year. To do that, imagine looping back around for the next full year.
 */
enum Month: Int {
  case january = 1, february, march, april, may, june, july, august, september, october, november, december
  
  var monthsUntilSummer: Int {
    var monthsLeft = Month.june.rawValue - self.rawValue
    if monthsLeft < 0 {
      monthsLeft += 12
    }
    return monthsLeft
  }
}

let month = Month.november
let monthsLeft = month.monthsUntilSummer // 7
