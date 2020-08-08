/// Copyright (c) 2020 Razeware LLC
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

protocol DollMaterial{
  init()
}

struct Wood: DollMaterial {}
struct Plastic: DollMaterial {}

protocol Matryoshka {
  associatedtype Material: DollMaterial

  associatedtype Inside: Matryoshka
//  where Self.Material == Self.Inside.Material,
//    Self.Inside == Self.Inside.Inside
//  , Self == Self.Inside

  var material: Material {get set}
  var inside: Inside? {get set}
}

struct TopMatryoshka<Material: DollMaterial>: Matryoshka {
  var material: Material = Material()
  var inside: InsideMatryoshka<Material>?
  var armSize = 4
  var polish = "Glossy"
}

class InsideMatryoshka<Material: DollMaterial>: Matryoshka {
  var material: Material = Material()
  var inside: InsideMatryoshka?
}

var topDoll = TopMatryoshka<Plastic>()
var insideDoll1 = InsideMatryoshka<Plastic>()
var insideDoll2 = InsideMatryoshka<Plastic>()
var insideDoll3 = InsideMatryoshka<Wood>()

topDoll.inside = insideDoll1
insideDoll1.inside = insideDoll2
//insideDoll2.inside = insideDoll3 //Error

