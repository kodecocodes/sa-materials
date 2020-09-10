/**
 * Copyright (c) 2020 Razeware LLC
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
 
 Build a new type, `Image`, that represents a simple image. It should also provide mutating functions that apply modifications to the image. Use copy-on-write to economize use of memory in the case where a user defines a large array of these identical images, and does not mutate any of them.
 
 To get you started, assume you are using the following Pixels class for the raw storage.
 
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
 
 Your image should be able to set and get individual pixel values as well as set all the values at once. Typical usage:
 
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
 
 If you were Apple and wanted to modify `UIImage` to replace it with a value type that had the mutating functions described above, could you do this in a way that is backward compatible with code which uses the existing `UIImage` API?
 */
// Yes. Because UIImage is already immutable, it already has value semantics.  Using a copy-on-write implementation you could introduce mutating methods while preserving value semantics. Since adding mutability to its API would only be adding new behaviors, rather than modifying existing ones, this would be backward-compatible with existing use sites.

/*:
 ### Challenge 3: Generic property wrapper for CopyOnWrite

 Consider the property wrapper `CopyOnWriteColor` you defined in this chapter. It lets you wrap any variable of type `Color` and it manages the sharing of an underlying storage type, `Bucket`, which own a single `Color` instance. Thanks to structural sharing, multiple `CopyOnWriteColor` instances might share the same `Bucket` instance, thus sharing its `Color` instance, thus saving memory.

 That property wrapper was only good for `Color` properties stored in a `Bucket` type. But the basic idea is more general, and depends on two key facts. First, that the wrapped value type, `Color`, already has value semantics — this fact is what ensured that assigning `Color` values into `Bucket`s did not produce unintended sharing at the level of `Color` type itself. Second, that `Bucket` itself has reference semantics — this fact is what allows us to use it as the instance which may be structurally shared across instances of whatever type contains the wrapped property, e.g., `PaintingPlan`s. That is, for the purposes of implementing the copy-on-write logic, what matters about `Bucket` is not its domain semantics (like `isRefilled`) but just that it is a reference type. You only used it as a _box_ for the `Color` value.

 Since property wrappers can be generic, you can define a _generic_ copy-on-write property property wrapper type, `CopyOnWrite`. Instead of being able to wrap only `Color` values, it should be generic over any value semantic that it wraps. And so instead of using a dedicated storage type like `Bucket`, it should provide its own box type to act as storage.

 Your challenge: write the definition for this generic type, `CopyOnWrite`, and use it in an example to verify that the wrapped properties preserve the value semantics of the original type. To get you started, here is a suitable definition of a box type:
 */
private class StorageBox<StoredValue> {
  var value: StoredValue
  
  init(_ value: StoredValue) {
    self.value = value
  }
}
//: challenge answer:

@propertyWrapper
  struct CopyOnWrite<T> {
  private var storage: StorageBox<T>
  
  init(wrappedValue: T) {
    self.storage = StorageBox(wrappedValue)
  }
  
  var wrappedValue:T {
    get {
      print("GET")
      return storage.value
    }
    set {
      print("SET")
      if isKnownUniquelyReferenced(&storage) {
        print("   set by mutating boxed value")
        storage.value = newValue
      } else {
        print("   set by deep copying the value into a new box")
        storage = StorageBox(newValue)
      }
    }
  }
}

struct Foo {
  @CopyOnWrite var x = 5
}

var f = Foo()
var g = f
print(f.x) // => 5
print(g.x) // => 5
f.x = 6
print(f.x) // => 6
print(g.x) // => 5
g.x = 10
print(f.x) // => 6
print(g.x) // => 10
/*:

You've now seen a few copy-on-write implementations: the original `Color` and `Bucket` types, the rewrite of them using property wrappers, the `Image` and `Pixels` type, and the generic `CopyOnWrite` wrapper. But how valuable are these?

In most cases, they are probably unnecessary. This is because, as was mentioned in the chapter, the Swift language is _already_ employing the copy-on-write optimization under the hood for value types. So writing an explicit copy-on-write logic for a raw memory `UInt8` buffer, like `Pixels`, is likely to reproduce explicitly the optimization that Swift itself already provides implicitly for a plain vanilla `Array<UInt8>`.

In practice, the main value of an explicit implementation, like the one above, is that you monitor the optimization and be certain it is applied. Swift's automatic copy-on-write behavior is not thoroughly documented, it is subject to its own compiler and runtime optimizations, and is therefore risky to rely on. Second, you would need to write an explicit implementation if you wished to implement much finer-grained structural sharing, for instance copying only mutated _parts_ of an array (which would therefore no longer be guaranteed to be contiguous in memory).

*/

/*

 ### Challenge 4: Determining if a type has value semantics

The last challenged developed a property wrapper `@CopyOnWrite`, which provides the copy-on-write optimization for types which are already value semantic. As discussed, this only lets you reproduce explicitly the storage optimization which the language runtime might be providing you under the hood. It does not _modify the semantics_ of assignment to that property.

 What is likely to be more useful is to have a property wrapper, `@ValueSemantics`,  that let you take an existing property of a type which currently does _not_ have value semantics, and to turn it into a property which _does_ have value semantics (using copy-on-write optimization to do so efficiently). Endowing the property with value semantics -- not copy-on-write as such -- is what provides the immunity from side effects, the important thing for a safer programming model.

 The key difference in a property wrapper that does work (versus `@CopyOnWrite` wrapper above), is that it will need to be generic over types _which might not currently offer value semantics_ like plain old mutable reference type and even value types which contain such reference types. Since you can no longer rely on assignment to do a deep copy of such a type you will need to _require_ that the type itself know how to do a deep copy of itself in order to be used by this property wrapper.

 This requirement can be established by requiring the type to conform to the following protocol:

 */


/*
 
 ### Challenge 4: Implement @ValueSemantic

 Using the following protocol `DeepCopyable` as a constraint, write the definition for this generic property wrapper type, `@ValueSemantic`, and use it in an example to verify that the wrapped properties have value semantics, even when they are wrapping an underlying type which does not. Use `NSMutableString` is an example of a non-value semantic type.
 */

protocol DeepCopyable {
  /*

   Returns a _deep copy_ of the current instance.

   If `x` is a deep copy of `y`, then:
   - the instance `x` should have the same value as `y` (for some sensible definition of value -- _not_ just memory location or pointer equality!)
   - it should be impossible to do any operation on `x` that will modify the value of the instance `y`.

   If the conforming type is a reference type (or otherwise does not have value semantics), then the way to achieve a deep copy is by ensuring that `x` and `y` do not share any storage, do not contain any properties that share any storage, and so on..

   If the conforming type already has value semantics then it already meets these requirements, and it suffices to return `self`. But in this case, there's no point to using the `@ValueSemantic` property wrapper.

   */
  func deepCopy() -> Self
}

//: challenge answer:

@propertyWrapper
  struct ValueSemantic<T:DeepCopyable> {
  private var storage: StorageBox<T>

  init(wrappedValue: T) {
    self.storage = StorageBox(wrappedValue)
  }

  var wrappedValue:T {
    // get could be getting the reference in order to call a mutating method on a reference type,
    // so we need to be defensive and treat this as a mutation of the value of the instance
    mutating get {
      print("GET")
      if isKnownUniquelyReferenced(&storage) {
        print("   getting the one instance in the uniquely held box")
        return storage.value
      } else {
        // this get might be readonly access to the boxed instance, but it might be
        // to call a method that mutates the boxed instance
        // we cannot know, so if we're sharing the box we need to stop doing so
        print("   getting, after deep copying to ensure we return an isolated instance")
        storage = StorageBox(storage.value.deepCopy())
        return storage.value
      }
    }
    set {
      print("SET")
      if isKnownUniquelyReferenced(&storage) {
        print("   setting by mutating boxed value")
        storage.value = newValue
      } else {
        print("   setting by deep copying the value into a new box")
        storage = StorageBox(newValue.deepCopy())
      }
    }
  }
}

extension NSMutableString : DeepCopyable {
  func deepCopy() -> Self {
    return self.mutableCopy() as! Self
  }
}

do {
  struct Foo {
    @ValueSemantic var x = NSMutableString.init(string: "hello")
  }

  print("valuesemantics")
  var f = Foo()
  var g = f
  print(f.x) // => "hello"
  print(g.x) // => "hello"
  // mutate the value of f by mutating the reference x
  f.x = NSMutableString.init(string: "world")
  print(f.x) // => "world"
  print(g.x) // => "hello" // good, no side-effects

  var a = Foo()
  var b = a
  print(a.x) // => "hello"
  print(b.x) // => "hello"
  // mutate the value of a by mutating the instance pointed to by the reference x
  a.x.append(" world")
  print(a.x) // => "hello world"
  print(b.x) // => "hello" // good, no side-effects

}


/*:
 ### Challenge 5
 
 Consider the test snippet used to determine if a type has value semantics. What would you need to do in order to define an automatic means to test if a type supports value semantics? If someone hands you a type, can you know for sure if it offers value semantics? What if you cannot see its implementation? Could the compiler be expected to know?
 */
/* The test snippet defines an _operational_ test of value semantics. The recipe for value semantic constitutes a more limited _deductive_ test. What is the potential for automating either of these?
 
 The operational test would be challenging to automate. Just as it is difficult to prove something does not exist (because you might not have looked hard enough yet) it is difficult to *prove* value semantics. As soon as some interaction with a variable has a side-effect on another variable, then you have shown the variable is not of a value semantic type. But how could you ever know that you have tried all possible interactions? One could imagine automatic tests that tried a large variety of random interactions, to see if one generated side-effects, but this would not be a comprehensive test. Similarly, one detects side-effects in the code snippet by seeing changes in the value of a variable. To automate this would require an automated way to determine the value of a variable, which would be difficult to do explicitly for types which do not define an `Equatable` implementation based on their contents.
 
 A deductive test of value semantics, based on the recipe for value semantics, would also be imperfect. In particular cases 1-3 appear to be possible to check automatically, since they amount to checking relatively simple aspects of types and their properties, questions like "is it a primitive value type?", "Are all the properties constant?", etc.. However, case 4, the case of value types containing mutable reference types, seems less susceptible to automated verification.
 */

