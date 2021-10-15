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

class Tutorial {
  let title: String
  unowned let author: Author
  weak var editor: Editor?
  
  init(title: String, author: Author) {
    self.title = title
    self.author = author
  }
  
  deinit {
    print("Goodbye tutorial \(title)!")
  }
  
  /*
  lazy var description: () -> String = {
    [unowned self] in
    "\(self.title) by \(self.author.name)"
  }
  
  lazy var description: () -> String = {
    [weak self] in
    "\(self?.title) by \(self?.author.name)"
  }
  */
  
  lazy var description: () -> String = {
    [weak self] in
    guard let self = self else {
      return "The tutorial is no longer available."
    }
    return "\(self.title) by \(self.author.name)"
  }
}

class Editor {
  let name: String
  var tutorials: [Tutorial] = []
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("Goodbye editor \(name)!")
  }
}

class Author {
  let name: String
  var tutorials: [Tutorial] = []
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("Goodbye author \(name)!")
  }
}

do {
  let author = Author(name: "Cosmin")
  let tutorial = Tutorial(title: "Memory management", author: author)
  print(tutorial.description())
  let editor = Editor(name: "Ray")
  author.tutorials.append(tutorial)
  tutorial.editor = editor
  editor.tutorials.append(tutorial)
}

final class FunctionKeeper {
  private let function: () -> Void
  
  init(function: @escaping () -> Void) {
    self.function = function
  }
  
  func run() {
    function()
  }
}

let name = "Cosmin"
let f = FunctionKeeper {
  print("Hello, \(name)")
}
f.run()

var counter = 0
var g = {print(counter)}
counter = 1
g()

counter = 0
g = {[c = counter] in print(c)}
counter = 1
g()

counter = 0
g = {[counter] in print(counter)}
counter = 1
g()

let tutorialDescription: () -> String
do {
  let author = Author(name: "Cosmin")
  let tutorial = Tutorial(title: "Memory management", author: author)
  tutorialDescription = tutorial.description
}
print(tutorialDescription())









