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

import Foundation
//: Pet shop tasks
//:
//: Create a collection of protocols for tasks that need doing at a pet shop. The pet shop has dogs, cats, fish and birds.
//: The pet shop duties include these tasks:
//:
//: * All pets need to be fed.
//:
//: * Pets that can fly need to be caged.
//:
//: * Pets that can swim need a tank.
//:
//: * Pets that walk need exercise.
//:
//: * Tanks, cages, and litter boxes need to be cleanded occasionally.
//:

//: 1. Create classes or structs for each animal and adopt the appropriate protocols. Feel free to simply use a print() statement for the method implementations.

protocol Feedable {
  func feed()
}

protocol Cleanable {
  func clean()
}

protocol Cageable: Cleanable {
  func cage()
}

protocol Tankable: Cleanable {
  func tank()
}

protocol Walkable {
  func walk()
}

class Dog: Feedable, Walkable {
  func feed() {
    print("Woof...thanks!")
  }

  func walk() {
    print("Walk the dog")
  }
}

class Cat: Feedable, Cleanable {
  func feed() {
    print("Yummy meow")
  }

  func clean() {
    print("Litter box cleaned")
  }
}

class Fish: Feedable, Tankable {
  func feed() {
    print("Fish goes blub")
  }

  func tank() {
    print("Fish has been tanked")
  }

  func clean() {
    print("Fish tank has been cleaned")
  }
}

class Bird: Feedable, Cageable {
  func feed() {
    print("Tweet!")
  }

  func cage() {
    print("Cage the bird")
  }

  func clean() {
    print("Clean the cage")
  }
}

//: 2. Create homogenous arrays for animals that need to be fed, caged, cleaned, walked, and tanked. Add the appropriate animals to these arrays. The arrays should be declared using the protocol as the element type, for example `var caged: [Cageable]`.

let dog = Dog()
let cat = Cat()
let fish = Fish()
let bird = Bird()

let walkingDuties: [Walkable] = [dog]
let feedingDuties: [Feedable] = [dog, cat, fish, bird]
let tankingDuties: [Tankable] = [fish]
let cagingDuties: [Cageable] = [bird]
let cleaningDuties: [Cleanable] = [cat, fish, bird]

// Swift's type system prevents you from adding something that
// can't be walked to a homogenous list of `Walkable`!
// let invalidWalkingDuties: [Walkable] = [dog, fish]

//: 3. Write a loop that will perform the proper tasks (such as feed, cage, walk) on each element of each array.

for walkable in walkingDuties {
  walkable.walk()
}

for feedable in feedingDuties {
  feedable.feed()
}

for tankable in tankingDuties {
  tankable.tank()
}

for cageable in cagingDuties {
  cageable.cage()
}

for cleanable in cleaningDuties {
  cleanable.clean()
}
