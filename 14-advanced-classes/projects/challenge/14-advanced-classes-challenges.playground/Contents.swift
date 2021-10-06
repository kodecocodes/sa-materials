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
 ## Advanced Classes
 ### Challenge 1
 Create three simple classes called `A`, `B`, and `C` where `C` inherits from `B` and `B` inherits from `A`. In each class initializer, call `print("I'm <X>!")` both before and after `super.init()`. Create an instance of `C` called `c`.  What order do you see each `print()` called in?
 */
// See below.
/*:
 ### Challenge 2
  Implement `deinit` for each class. Place your `c` inside of a `do { }` scope which will cause the reference count to go to zero when it exits the scope. What order are the classes deinitialized in?
 */
class A {
  init() {
    print("I'm A!(1)")
  }
  deinit {
    print("Destroy A")
  }
}

class B: A {
  deinit {
    print("Destroy B")
  }
  override init() {
    print("I'm B!(1)")
    super.init()
    print("I'm B!(2)")
  }
}

class C: B {
  deinit {
    print("Destroy C")
  }
  override init() {
    print("I'm C!(1)")
    super.init()
    print("I'm C!(2)")
  }
}

do {
  let _ = C()
}
/*:
 ### Challenge 3
 Cast the instance of type `C` to an instance of type `A`. Which casting operation do you use and why?
 */
do {
  let c = C()
  let _ = c as A
  // The `as` keyword can be used because `C` is a subtype of `A`.
}
/*:
### Challenge 4
Create a subclass of `StudentAthlete` called `StudentBaseballPlayer` and include properties for `position`, `number`, and `battingAverage`.  What are the benefits and drawbacks of subclassing `StudentAthlete` in this scenario?
 */
class Person {
  var firstName: String
  var lastName: String

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

struct Grade {
  let letter: String
  let points: Double
}

class Student: Person {
  var grades: [Grade] = []
}

class StudentAthlete: Student {
  var sports: [String] = []
}

class StudentBaseballPlayer: StudentAthlete {
  var battingAverage = 0.0
  var number: Int
  var position: String

  init(firstName: String, lastName: String, number: Int, position: String) {
    self.number = number
    self.position = position
    super.init(firstName: firstName, lastName: lastName)
  }
}

/*
 Benefits:

 - Automatically get properties all student atheletes will have - grades and names
 - Type relationship with superclasses. StudentBaseballPlayer _is_ a Student

 Drawbacks:

 - An initializer that is beginning to get bloated
 - `sports` is a bit awkward to a baseball player object
 - Deep class hierarchy would make similar classes difficult. For instance, an almost identical class would need to be made for a `SoftballPlayer` who joined a league after graduating. They would no longer be a `Student`, only a `Person`!
*/





