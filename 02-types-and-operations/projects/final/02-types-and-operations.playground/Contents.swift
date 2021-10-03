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

// CONVERTING TYPES
var integer: Int = 100
var decimal: Double = 12.5
//integer = decimal /* Cannot assign value of type 'Double' to type 'Int' */
integer = Int(decimal)

let hourlyRate: Double = 19.5
let hoursWorked: Int = 10
//let totalCost: Double = hourlyRate * hoursWorked /* Binary operator '*' cannot be applied to operands of type 'Double' and 'Int' */
let totalCost: Double = hourlyRate * Double(hoursWorked)


// TYPE INFERENCE
let typeInferedInt = 42 /* Type = Int */
let typeInferedDouble = 3.14159 /* Type = Double */

let wantADouble = 3 /* Type = Int */
let actuallyDouble = Double(3)
//let actuallyDouble: Double = 3
//let actuallyDouble = 3 as Double
//let wantADouble = 3.0

// CHARACTERS
let characterA: Character = "a"
let characterDog: Character = "🐶"
let stringDog = "Dog"


// STRING CONCATENTATION
var message = "Hello" + " my name is "
let name = "Matt"
message += name

let exclamationMark: Character = "!"
message += String(exclamationMark)


// STRING INTERPOLATION
message = "Hello my name is \(name)!"

let oneThird = 1.0 / 3.0
let oneThirdLongString = "One third is \(oneThird) as a decimal."


// LONG STRINGS
let bigString = """
  You can have a string
  that contains multiple
  lines
  by
  doing this.
  """
print(bigString)


// TUPLES
let coordinates = (2, 3) /* Type = (Int, Int) */
let coordinatesDoubles = (2.1, 3.5) /* Type = (Double, Double) */
let coordinatesMixed = (2.1, 3) /* Type = (Double, Int) */

let x1 = coordinates.0
let y1 = coordinates.1

let coordinatesNamed = (x: 2, y: 3)
let x2 = coordinatesNamed.x
let y2 = coordinatesNamed.y

let coordinates3D = (x: 2, y: 3, z: 1)
let (x3, y3, z3) = coordinates3D
//let x3 = coordinates3D.x
//let y3 = coordinates3D.y
//let z3 = coordinates3D.z

let (x4, y4, _) = coordinates3D

// NUMBER TYPES
let a: Int16 = 12
let b: UInt8 = 255
let c: Int32 = -100000

let answer = Int(a) + Int(b) + Int(c)  // answer is an Int

typealias Animal = String
let myPet: Animal = "Dog"

typealias Coordinates = (Int, Int)
let xy: Coordinates = (2, 4)
