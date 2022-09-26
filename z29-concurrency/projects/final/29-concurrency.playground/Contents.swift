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

import SwiftUI

Task {
  print("Doing some work on a task")
}
print("Doing some work on the main actor")

Task {
  print("Doing some work on a task")
  let sum = (1...100).reduce(0, +)
  print("1 + 2 + 3 ... 100 = \(sum)")
}

print("Doing some work on the main actor")

let task = Task {
  print("Doing some work on a task")
  let sum = (1...100).reduce(0, +)
  try Task.checkCancellation()
  print("1 + 2 + 3 ... 100 = \(sum)")
}

print("Doing some work on the main actor")
task.cancel()

Task {
  print("Hello")
  try await Task.sleep(nanoseconds: 1_000_000_000)
  print("Goodbye")
}

func helloPauseGoodbye() async throws {
  print("Hello")
  try await Task.sleep(nanoseconds: 1_000_000_000)
  print("Goodbye")
}

Task {
  try await helloPauseGoodbye()
}

struct Domains: Decodable {
  let data: [Domain]
}

struct Domain: Decodable {
  let attributes: Attributes
}

struct Attributes: Decodable {
  let name: String
  let description: String
  let level: String
}

func fetchDomains() async throws -> [Domain] {
  let url = URL(string: "https://api.raywenderlich.com/api/domains")!
  let (data, _) = try await URLSession.shared.data(from: url)
  return try JSONDecoder().decode(Domains.self, from: data).data
}

Task {
  do {
    let domains = try await fetchDomains()
    for domain in domains {
      let attr = domain.attributes
      print("\(attr.name): \(attr.description) - \(attr.level)")
    }
  } catch {
    print(error)
  }
}

func findTitle(url: URL) async throws -> String? {
  for try await line in url.lines {
    if line.contains("<title>") {
      return line.trimmingCharacters(in: .whitespaces)
    }
  }
  return nil
}

Task {
  if let title = try await findTitle(url: URL(string: "https://www.raywenderlich.com")!) {
    print(title)
  }
}

func findTitlesSerial(first: URL, second: URL) async throws -> (String?, String?) {
  let title1 = try await findTitle(url: first)
  let title2 = try await findTitle(url: second)
  return (title1, title2)
}

/*
func findTitlesParallel(first: URL, second: URL) async throws -> (String?, String?) {
  async let title1 = findTitle(url: first)
  async let title2 = findTitle(url: second)
  let titles = try await [title1, title2]
  return (titles[0], titles[1])
}
*/

//Warning: The commented asynchronous code only works in projects.

extension Domains {
  static var domains: [Domain] {
    get async throws {
      try await fetchDomains()
    }
  }
}

Task {
  dump(try await Domains.domains)
}

extension Domains {
  enum Error: Swift.Error {case outOfRange}
  
  static subscript(_ index: Int) -> String {
    get async throws {
      let domains = try await Self.domains
      guard domains.indices.contains(index) else {throw Error.outOfRange}
      return domains[index].attributes.name
    }
  }
}

Task {
  dump(try await Domains[4])
}

actor Playlist {
  let title: String
  let author: String
  private(set) var songs: [String]
  
  init(title: String, author: String, songs: [String]) {
    self.title = title
    self.author = author
    self.songs = songs
  }
  
  func add(song: String) {
    songs.append(song)
  }
  
  func remove(song: String) {
    guard !songs.isEmpty, let index = songs.firstIndex(of: song) else {return}
    songs.remove(at: index)
  }
  
  func move(song: String, from playlist: Playlist) async {
    await playlist.remove(song: song)
    add(song: song)
  }
  
  func move(song: String, to playlist: Playlist) async {
    await playlist.add(song: song)
    remove(song: song)
  }
}

let favorites = Playlist(title: "Favorite songs", author: "Cosmin", songs: ["Nothing else matters"])
let partyPlaylist = Playlist(title: "Party songs", author: "Ray", songs: ["Stairway to heaven"])

Task {
  await favorites.move(song: "Stairway to heaven", from: partyPlaylist)
  await favorites.move(song: "Nothing else matters", to: partyPlaylist)
  await print(favorites.songs)
}

extension Playlist: CustomStringConvertible {
  nonisolated var description: String {
    "\(title) by \(author)."
  }
}

print(favorites)

final class BasicPlaylist {
  let title: String
  let author: String
  
  init(title: String, author: String) {
    self.title = title
    self.author = author
  }
}

extension BasicPlaylist: Sendable {}

func execute(task: @escaping @Sendable () -> Void, with priority: TaskPriority? = nil) {
  Task(priority: priority, operation: task)
}

@Sendable func showRandomNumber() {
  let number = Int.random(in: 1...10)
  print(number)
}

execute(task: showRandomNumber)
