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
class Cat {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

class Dog {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

class Keeper<Animal> {
  var name: String
  var morningCare: Animal
  var afternoonCare: Animal
  
  init(name: String, morningCare: Animal, afternoonCare: Animal) {
    self.name = name
    self.morningCare = morningCare
    self.afternoonCare = afternoonCare
  }
}
// Mini-exercise 1: Try instantiating another `Keeper`, but this time for dogs.

// let us suppose that Sally is the name of a person who looks after dogs, a dog named "Benji" in the morning and dog named "Rufus" in the afternoon

let sally = Keeper(name: "Sally", morningCare: Dog(name: "Benji"), afternoonCare: Dog(name: "Rufus"))

// Mini-exercise 2: What do you think would happen if you tried to instantiate a `Keeper` with a dog in the morning and a cat in the afternoon?

// This app does not drive a nuclear reactor. The best way to find out is to try! Let us uncomment the following line

// let paul = Keeper(name: "Paul", morningCare: Dog(name: "Lucky"), afternoonCare: Cat(name: "Sleepy"))

/*
 The error we get is the following: Conflicting arguments to generic parameter 'Animal' ('Dog' vs 'Cat').

 This is exactly what we'd expect. Swift needs the generic parameter `Animal` to take one type, so there is a conflict if `morningCare` parameter and the `afternoonCare` parameter expect different types.
*/

// Mini-exercise 3: What happens if you try to instantiate a `Keeper`, but for strings?

// This works. As you'll learn in the next section, type constraints can help you avoid this problem.

let stringKeeper = Keeper(name: "StringKeeper", morningCare: "", afternoonCare: "")



