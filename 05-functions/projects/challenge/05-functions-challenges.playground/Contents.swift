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
 ### Challenge 1: Looping with stride functions
 
 In the last chapter you wrote some `for` loops with ranges. Ranges are limited in that they must always be increasing. The Swift `stride(from:to:by:)` and `stride(from:through:by:)` functions let you loop much more flexibly.  For example, if you wanted to loop from 10 to 20 by 4s you can write:
 
 ```swift
 for index in stride(from: 10, to: 22, by: 4) {
   print(index)
 }
 // prints 10, 14, 18
 
 for index in stride(from: 10, through: 22, by: 4) {
   print(index)
 }
 // prints 10, 14, 18, and 22
 ```
 
 - What is the difference between the two stride function overloads?
 - Write a loop that goes from 10.0 to (and including) 9.0, decrementing by 0.1.
 */

// stride(from:to:by:) does NOT include the final number (like half-open range)
// stride(from:through:by:) does include the final number (like closed range)

for index in stride(from: 10, through: 9, by: -0.1) {
  print(index)
}


/*:
 ### Challenge 2: It’s prime time
 
 When I’m acquainting myself with a programming language, one of the first things I do is write a function to determine whether or not a number is prime. That’s your second challenge.
 
 First, write the following function:
 
 ```swift
 func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool
 ```
 
 You’ll use this to determine if one number is divisible by another. It should return `true` when `number` is divisible by `divisor`.
 
 **Hint**: You can use the modulo (`%`) operator to help you out here.
 
 Next, write the main function:
 
 ```swift
 func isPrime(_ number: Int) -> Bool
 ```
 
 This should return `true` if `number` is prime, and `false` otherwise. A number is prime if it’s only divisible by 1 and itself. You should loop through the numbers from 1 to the number and find the number’s divisors. If it has any divisors other than 1 and itself, then the number isn’t prime. You’ll need to use the `isNumberDivisible(_:by:)` function you wrote earlier.
 
 Use this function to check the following cases:
 
 ```swift
 isPrime(6) // false
 isPrime(13) // true
 isPrime(8893) // true
 ```
 
 **Hint 1**: Numbers less than 0 should not be considered prime. Check for this case at the start of the function and return early if the number is less than 0.
 
 **Hint 2**: Use a `for` loop to find divisors. If you start at two and end before the number itself, then as soon as you find a divisor, you can return `false`.
 
 **Hint 3**: If you want to get *really* clever, you can simply loop from two until you reach the square root of `number` rather than going all the way up to `number` itself. I’ll leave it as an exercise for you to figure out why. It may help to think of the number 16, whose square root is 4. The divisors of 16 are 1, 2, 4, 8 and 16.
 */

func isNumberDivisible(_ number: Int, by divisor: Int) -> Bool {
  number % divisor == 0
}

func isPrime(_ number: Int) -> Bool {
  if number < 0 {
    return false
  }
  
  /*
   We handle these cases up front because we want to make sure the range 2...root (used below) is valid, which is the case only when root >= 2, so for numbers >= 4.
   */
  if number <= 3 {
    return true
  }

  let doubleNumber = Double(number)
  let root = Int(doubleNumber.squareRoot())
  for divisor in 2...root {
    if isNumberDivisible(number, by: divisor) {
      return false
    }
  }
  return true
}
isPrime(6)
isPrime(13)
isPrime(8893)


/*: 
 ### Challenge 3: Recursive functions
 
 In this challenge, you will see what happens when a function calls *itself*, a behavior called **recursion**. This may sound unusual, but it can be quite useful.
 
 You’re going to write a function that computes a value from the **Fibonacci sequence**. Any value in the sequence is the sum of the previous two values. The sequence is defined such that the first two values equal 1. That is, `fibonacci(1) = 1` and `fibonacci(2) = 1`.
 
 Write your function using the following declaration:
 
 ```swift
 func fibonacci(_ number: Int) -> Int
 ```
 
 Then, verify you’ve written the function correctly by executing it with the following numbers:
 
 ```swift
 fibonacci(1)  // = 1
 fibonacci(2)  // = 1
 fibonacci(3)  // = 2
 fibonacci(4)  // = 3
 fibonacci(5)  // = 5
 fibonacci(10) // = 55
 ```
 
 **Hint 1**: For values of `number` less than 0, you should return 0.
 
 **Hint 2**: To start the sequence, hard-code a return value of 1 when `number` equals 1 or 2.
 
 **Hint 3**: For any other value, you’ll need to return the sum of calling `fibonacci` with `number - 1` and `number - 2`.
*/

func fibonacci(_ number: Int) -> Int {
  if number <= 0 {
    return 0
  }

  if number == 1 || number == 2 {
    return 1
  }

  return fibonacci(number - 1) + fibonacci(number - 2)
}
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(5)
fibonacci(10)
