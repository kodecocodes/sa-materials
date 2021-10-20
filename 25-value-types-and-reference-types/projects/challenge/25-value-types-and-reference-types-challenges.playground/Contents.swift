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

import Foundation

/*:
 ## Value Types and Reference Types Challenges
 ### Challenge 1: Image with value semantics
 
 Build a new type, `Image`, that represents a simple image. It should also provide mutating functions that apply modifications to the image. Use copy-on-write to economize the use of memory when a user defines a large array of these identical images and doesn’t mutate any of them.

 To get started, assume you’re using the following Pixels class for the raw storage:
 
 ```swift
 private class Pixels {
   let storageBuffer: UnsafeMutableBufferPointer<UInt8>

   init(size: Int, value: UInt8) {
     let p = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
     storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: size)
     storageBuffer.initialize(from: repeatElement(value, count: size))
   }

   init(pixels: Pixels) {
     let otherStorage = pixels.storageBuffer
     let p = UnsafeMutablePointer<UInt8>.allocate(capacity: otherStorage.count)
     storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: otherStorage.count)
     storageBuffer.initialize(from: otherStorage)
   }

   subscript(offset: Int) -> UInt8 {
     get {
       storageBuffer[offset]
     }
     set {
       storageBuffer[offset] = newValue
     }
   }

   deinit {
     storageBuffer.baseAddress!.deallocate(capacity: self.storageBuffer.count)
   }
 }
 ```
 
 Your image should be able to set and get individual pixel values and set all values at once. Typical usage:

 ```swift
 var image1 = Image(width: 4, height: 4, value: 0)
 
 // test setting and getting
 image1[0,0] // -> 0
 image1[0,0] = 100
 image1[0,0] // -> 100
 image1[1,1] // -> 0
 
 // copy
 var image2 = image1
 image2[0,0] // -> 100
 image1[0,0] = 2
 image1[0,0] // -> 2
 image2[0,0] // -> 100 because of copy-on-write
 
 var image3 = image2
 image3.clear(with: 255)
 image3[0,0] // -> 255
 image2[0,0] // -> 100 thanks again, copy-on-write
 ```

 */
private class Pixels {
  let storageBuffer: UnsafeMutableBufferPointer<UInt8>

  init(size: Int, value: UInt8) {
    let p = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
    storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: size)
    storageBuffer.initialize(repeating: value)
  }

  init(pixels: Pixels) {
    let otherStorage = pixels.storageBuffer
    let p  = UnsafeMutablePointer<UInt8>.allocate(capacity: otherStorage.count)
    storageBuffer = UnsafeMutableBufferPointer<UInt8>(start: p, count: otherStorage.count)
    storageBuffer.initialize(from: otherStorage)
  }
  
  subscript(offset: Int) -> UInt8 {
    get {
      storageBuffer[offset]
    }
    set {
      storageBuffer[offset] = newValue
    }
  }
  
  deinit {
    storageBuffer.deallocate()
  }
}

struct Image {
  private (set) var width: Int
  private (set) var height: Int
  private var pixels: Pixels
  private var mutatingPixels: Pixels {
    mutating get {
      if !isKnownUniquelyReferenced(&pixels) {
        pixels = Pixels(pixels: pixels)
      }
      return pixels
    }
  }

  init(width: Int, height: Int, value: UInt8) {
    self.width = width
    self.height = height
    self.pixels = Pixels(size: width * height, value: value)
  }
  
  subscript(x: Int, y: Int) -> UInt8 {
    get {
      return pixels[y * width + x]
    }
    set {
      mutatingPixels[y * width + x] = newValue
    }
  }
  
  mutating func clear(with value: UInt8) {
    for (i, _) in self.mutatingPixels.storageBuffer.enumerated() {
      self.mutatingPixels.storageBuffer[i] = value
    }
  }
}

var image1 = Image(width: 4, height: 4, value: 0)

// test setting and getting
image1[0,0] // -> 0
image1[0,0] = 100
image1[0,0] // -> 100
image1[1,1] // -> 0

// copy
var image2 = image1
image2[0,0] // -> 100
image1[0,0] = 2
image1[0,0] // -> 2
image2[0,0] // -> 100 because of copy-on-write

var image3 = image2
image3.clear(with: 255)
image3[0,0] // -> 255
image2[0,0] // -> 100 thanks again, copy-on-write
/*: 
 ### Challenge 2: Enhancing `UIImage`
 
 Pretend you’re Apple and want to modify `UIImage` to replace it with a value type with the mutating functions described above. Could you do make it backward compatible with code that uses the existing `UIImage` API?
 */
// Yes. Because UIImage is already immutable, it already has value semantics.  Using a copy-on-write implementation you could introduce mutating methods while preserving value semantics. Since adding mutability to its API would only be adding new behaviors, rather than modifying existing ones, this would be backward-compatible with existing use sites.

/*:
 ### Challenge 3
 
 Consider the test snippet used to determine if a type has value semantics. What would you need to do in order to define an automatic means to test if a type supports value semantics? If someone hands you a type, can you know for sure if it offers value semantics? What if you cannot see its implementation? Could the compiler be expected to know?
 */
/* The test snippet defines an _operational_ test of value semantics. The recipe for value semantic constitutes a more limited _deductive_ test. What is the potential for automating either of these?
 
 The operational test would be challenging to automate. Just as it is difficult to prove something does not exist (because you might not have looked hard enough yet) it is difficult to *prove* value semantics. As soon as some interaction with a variable has a side-effect on another variable, then you have shown the variable is not of a value semantic type. But how could you ever know that you have tried all possible interactions? One could imagine automatic tests that tried a large variety of random interactions, to see if one generated side-effects, but this would not be a comprehensive test. Similarly, one detects side-effects in the code snippet by seeing changes in the value of a variable. To automate this would require an automated way to determine the value of a variable, which would be difficult to do explicitly for types which do not define an `Equatable` implementation based on their contents.
 
 A deductive test of value semantics, based on the recipe for value semantics, would also be imperfect. In particular cases 1-3 appear to be possible to check automatically, since they amount to checking relatively simple aspects of types and their properties, questions like "is it a primitive value type?", "Are all the properties constant?", etc.. However, case 4, the case of value types containing mutable reference types, seems less susceptible to automated verification.
 */

