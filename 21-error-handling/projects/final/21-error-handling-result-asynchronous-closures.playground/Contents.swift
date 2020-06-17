/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import Foundation

func log(message: String) {
  let thread = Thread.current.isMainThread ? "Main" : "Background"
  print("\(thread) thread: \(message).")
}

func addNumbers(upTo range: Int) -> Int {
  log(message: "Adding numbers...")
  return (1...range).reduce(0, +)
}

let queue = DispatchQueue(label: "queue")

func execute<Result>(backgroundWork: @escaping () -> Result, mainWork: @escaping (Result) -> ()) {
  queue.async {
    let result = backgroundWork()
    DispatchQueue.main.async {
      mainWork(result)
    }
  }
}

execute(backgroundWork: { addNumbers(upTo: 100) }, mainWork:  { log(message: "The sum is \($0)") })

struct Tutorial {
  let title: String
  let author: String
}

enum TutorialError: Error {
  case rejected
}

func feedback(for tutorial: Tutorial) -> Result<String, TutorialError> {
  Bool.random() ? .success("published") : .failure(.rejected)
}

func edit(_ tutorial: Tutorial) {
  queue.async {
    let result = feedback(for: tutorial)
    DispatchQueue.main.async {
      switch result {
        case let .success(data):
          print("\(tutorial.title) by \(tutorial.author) was \(data) on the website.")
        case let .failure(error):
          print("\(tutorial.title) by \(tutorial.author) was \(error).")
      }
    }
  }
}

let tutorial = Tutorial(title: "What's new in Swift 5.1", author: "Cosmin Pupăză")
edit(tutorial)

let result = feedback(for: tutorial)
do {
  let data = try result.get()
  print("\(tutorial.title) by \(tutorial.author) was \(data) on the website.")
} catch {
  print("\(tutorial.title) by \(tutorial.author) was \(error).")
}

