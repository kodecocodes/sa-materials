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
/*:
 ## Collection Iteration with Closures
 ### Challenge 1: Repeating yourself
 
 Your first challenge is to write a function that will run a given closure a given number of times.
 
 Declare the function like so:
 
 ```swift
 func repeatTask(times: Int, task: () -> Void)
 ```
 
 The function should run the `task` closure, `times` number of times.
 
 Use this function to print `"Swift Apprentice is a great book!"` 10 times.
 */
func repeatTask(times: Int, task: () -> Void) {
  for _ in 0..<times {
    task()
  }
}

repeatTask(times: 10) {
  print("Swift Apprentice is a great book!")
}
/*:
 ### Challenge 2: Closure sums
 
 In this challenge, you’re going to write a function that you can reuse to create different mathematical sums.
 
 Declare the function like so:
 
 ```swift
 func mathSum(length: Int, series: (Int) -> Int) -> Int
 ```
 
 The first parameter, `length`, defines the number of values to sum. The second parameter, `series`, is a closure that can be used to generate a series of values. `series` should have a parameter that is the position of the value in the series and return the value at that position.
 
 `mathSum` should calculate `length` number of values, starting at position 1, and return their sum.
 
 Use the function to find the sum of the first 10 square numbers, which equals 385. Then use the function to find the sum of the first 10 Fibonacci numbers, which equals 143. For the Fibonacci numbers, you can use the function you wrote in the functions chapter — or grab it from the solutions if you’re unsure your solution is correct.
 */
func mathSum(length: Int, series: (Int) -> Int) -> Int {
  var result = 0
  for i in 1...length {
    result += series(i)
  }
  return result
}

//// Extra credit if your solution was as follows!
//func mathSum(length: Int, series: (Int) -> Int) -> Int {
//  return (1...length).map { series($0) }.reduce(0, +)
//}

// Sum of first 10 square numbers
mathSum(length: 10) { number in
  number * number
}

// Alternate solution using shorthand syntax
mathSum(length: 10) {
  $0 * $0
}

func fibonacci(_ number: Int) -> Int {
  if number <= 0 {
    return 0
  }

  if number == 1 || number == 2 {
    return 1
  }

  return fibonacci(number - 1) + fibonacci(number - 2)
}

// Sum of first 10 fibonacci numbers.
// Note that you can't use a closure here as `fibonacci` is a recursive function and thus needs a name to be able to recursively call itself.
mathSum(length: 10, series: fibonacci)
/*:
 ### Challenge 3: Functional ratings
 
 In this final challenge you will have a list of app names with associated ratings they’ve been given (note — these are all fictional apps!).
 
 Create the data dictionary like so:
 */

 let appRatings = [
   "Calendar Pro": [1, 5, 5, 4, 2, 1, 5, 4],
   "The Messenger": [5, 4, 2, 5, 4, 1, 1, 2],
   "Socialise": [2, 1, 2, 2, 1, 2, 4, 2]
  ]
 
/*:
 First, create a dictionary called `averageRatings` which will contain a mapping of app names to average ratings. Then, use `forEach` to iterate through the `appRatings` dictionary, use `reduce` to calculate the average rating and store this rating in the `averageRatings` dictionary.
 
 Finally, use `filter` and `map` chained together to get a list of the app names whose average rating is greater than 3.
 */

var averageRatings: [String: Double] = [:]
appRatings.forEach {
  let total = $0.value.reduce(0, +) // + is a function too!
  averageRatings[$0.key] = Double(total) / Double($0.value.count)
}
averageRatings

let goodApps = averageRatings.filter {
  $0.value > 3
}.map {
  $0.key
}
