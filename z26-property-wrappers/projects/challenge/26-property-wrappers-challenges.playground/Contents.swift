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
 ## Property Wrapper Challenges
 ### Challenge 1: Generic property wrapper for CopyOnWrite

 Consider the property wrapper `CopyOnWriteColor` you defined in the previous chapter. It lets you wrap any variable of type `Color`, and it manages the sharing of an underlying storage type, `Bucket`, which owns a single `Color` instance. Thanks to structural sharing, multiple `CopyOnWriteColor` instances might share the same `Bucket` instance, thus sharing its `Color` instance, thus saving memory.

  That property wrapper was only suitable for `Color` properties stored in a `Bucket` type. But the idea is more general and depends on two key facts. First, that the wrapped value type, `Color`, already has value semantics — this fact is what ensured that assigning `Color` values into `Bucket`s did not produce unintended sharing at the level of `Color` type itself. Second, that `Bucket` itself has reference semantics — this fact is what allows us to use it as the instance which may be structurally shared across instances of whatever type contains the wrapped property, e.g., `PaintingPlan`s. To implement the copy-on-write logic, what matters about `Bucket` is not its domain semantics (like `isRefilled`) but just that it is a reference type. You only used it as a _box_ for the `Color` value.

  Since property wrappers can be generic, you can define a _generic_ copy-on-write property wrapper type, `CopyOnWrite`. Instead of being able to wrap only `Color` values, it should be generic over any value semantic that it wraps. Instead of using a dedicated storage type like `Bucket`, it should provide its own box type to act as storage. Your challenge: write the definition for this generic type, `CopyOnWrite`, and use it in an example to verify that the wrapped properties preserve the value semantics of the original type. To get you started, here is a suitable definition of a box type:
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

  var wrappedValue: T {
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

 ### Challenge 2: Implement @ValueSemantic

 Using `StorageBox` from the previous example and the following protocol, `DeepCopyable`, as a constraint, write the definition for a generic property wrapper `@ValueSemantic`. Then use it in an example to verify that wrapped properties have value semantics even when wrapping an underlying type that doesn't. Example: `NSMutableString` is an example of a non-value semantic type.  Make it conform to `DeepCopyable` and test it with `@ValueSemantic`.

 Hints:

 - If the `DeepCopyable` conforming type is a reference type or otherwise doesn't have value semantics, making a deep copy ensures properties don't share any storage and changes to one don't affect the other.

 - Note that if the conforming type already has value semantics, it meets these requirements, so it's enough to return `self`. In this case, however, there’s no point in using `@ValueSemantic`.

 */
protocol DeepCopyable {
  /* Returns a _deep copy_ of the current instance.

   If `x` is a deep copy of `y`, then:
   - the instance `x` should have the same value as `y` (for some sensible definition of value -- _not_ just memory location or pointer equality!)
   - it should be impossible to do any operation on `x` that will modify the value of the instance `y`.

  Note: a value semantic type implementing this protocol can just return `self` since that fulfills the above requirement.
  */
  func deepCopy() -> Self
}
//: challenge answer:
@propertyWrapper
struct ValueSemantic<T: DeepCopyable> {
  
  private var storage: StorageBox<T>

  init(wrappedValue: T) {
    self.storage = StorageBox(wrappedValue)
  }

  var wrappedValue: T {
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

extension NSMutableString: DeepCopyable {
  
  func deepCopy() -> Self {
    self.mutableCopy() as! Self
  }
}

do {
  struct Foo {
    @ValueSemantic var x = NSMutableString(string: "hello")
  }

  print("valuesemantics")
  var f = Foo()
  var g = f
  print(f.x) // => "hello"
  print(g.x) // => "hello"
  // mutate the value of f by mutating the reference x
  f.x = NSMutableString(string: "world")
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
