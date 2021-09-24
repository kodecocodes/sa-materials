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

import UIKit

struct Domains: Codable {
  let data: [Domain]
}

struct Domain: Codable {
  let attributes: Attributes
}

struct Attributes: Codable {
  let name, description, level: String
}

let string = "https://api.raywenderlich.com/api/domains"
let url = URL(string: string)!
let task = URLSession.shared.dataTask(with: url) {data, response, error in
  guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
    print(error ?? "Unknown error")
    return
  }
  do {
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}
task.resume()

Task {
  do {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

Task {
  do {
    let (bytes, response) = try await URLSession.shared.bytes(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    var data = Data()
    for try await byte in bytes {
      data.append(byte)
    }
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

Task {
  do {
    let (bytes, response) = try await URLSession.shared.bytes(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    var string = ""
    for try await line in bytes.lines {
      string.append(line)
    }
    let data = Data(string.utf8)
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

Task {
  do {
    let (bytes, response) = try await URLSession.shared.bytes(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    var string = ""
    for try await character in bytes.characters {
      string.append(character)
    }
    let data = Data(string.utf8)
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

Task {
  do {
    let (bytes, response) = try await URLSession.shared.bytes(from: url)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    var string = ""
    for try await scalar in bytes.unicodeScalars {
      let scalarString = String(scalar)
      string.append(scalarString)
    }
    let data = Data(string.utf8)
    let domains = try JSONDecoder().decode(Domains.self, from: data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

Task {
  do {
    async let (data, response) = URLSession.shared.data(from: url)
    guard let httpResponse = try await response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
    let domains = try JSONDecoder().decode(Domains.self, from: await data)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

func fetchDomains(for url: URL) async throws {
  let (data, response) = try await URLSession.shared.data(from: url)
  guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
  let domains = try JSONDecoder().decode(Domains.self, from: data)
  for domain in domains.data {
    let attributes = domain.attributes
    print("\(attributes.name): \(attributes.description) - \(attributes.level)")
  }
}

Task{
  do {
    try await fetchDomains(for: url)
  } catch {
    print(error)
  }
}

extension Domains {
  static var domains: Domains? {
    get async throws {
      let (data, response) = try await URLSession.shared.data(from: url)
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return nil}
      let domains = try JSONDecoder().decode(Domains.self, from: data)
      return domains
    }
  }
}

Task {
  do {
    if let domains = try await Domains.domains {
      for domain in domains.data {
        let attributes = domain.attributes
        print("\(attributes.name): \(attributes.description) - \(attributes.level)")
      }
    }
  } catch {
    print(error)
  }
}

extension Domains {
  static subscript(domain index: Int, attribute type: String) -> String? {
    get async throws {
      guard let domains = try await Domains.domains else {return nil}
      let data = domains.data
      guard 0..<data.count ~= index else {return nil}
      let attributes = data[index].attributes
      switch type {
        case "name": return attributes.name
        case "level": return attributes.level
        case "description": return attributes.description
        default: return nil
      }
    }
  }
}

Task {
  do {
    if let name = try await Domains[domain: 4, attribute: "name"] {
      print(name)
    }  
  } catch {
    print(error)
  }
}

enum DomainError: Error {
  case noNetwork, noData
}

func fetchDomains(for url: URL, completion: @escaping (Result<Domains, Error>) -> Void) {
  let task = URLSession.shared.dataTask(with: url) {data, response, error in
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      completion(.failure(error ?? DomainError.noNetwork))
      return
    }
    guard let data = data, let domains = try? JSONDecoder().decode(Domains.self, from: data) else {
      completion(.failure(error ?? DomainError.noData))
      return
    }
    completion(.success(domains))
  }
  task.resume()
}

fetchDomains(for: url) {result in
  switch result {
    case let .success(domains):
      for domain in domains.data {
        let attributes = domain.attributes
        print("\(attributes.name): \(attributes.description) - \(attributes.level)")
      }
    case let .failure(error): print(error)
  }
}

func fetchDomainsWithUnsafeContinuation(for url: URL) async -> Domains {
  await withUnsafeContinuation({continuation in
    fetchDomains(for: url) {result in
      switch result {
        case let .success(domains): continuation.resume(returning: domains)
        case let .failure(error): print(error)
      }
    }
  })
}

Task {
  let domains = await fetchDomainsWithUnsafeContinuation(for: url)
  for domain in domains.data {
    let attributes = domain.attributes
    print("\(attributes.name): \(attributes.description) - \(attributes.level)")
  }
}

func fetchDomainsWithCheckedContinuation(for url: URL) async -> Domains {
  await withCheckedContinuation({continuation in
    fetchDomains(for: url) {result in
      switch result {
        case let .success(domains): continuation.resume(returning: domains)
        case let .failure(error): print(error)
      }
    }
  })
}

Task {
  let domains = await fetchDomainsWithCheckedContinuation(for: url)
  for domain in domains.data {
    let attributes = domain.attributes
    print("\(attributes.name): \(attributes.description) - \(attributes.level)")
  }
}

func fetchDomainsWithUnsafeThrowingContinuation(for url: URL) async throws -> Domains {
  try await withUnsafeThrowingContinuation({continuation in
    fetchDomains(for: url) {result in
      switch result {
        case let .success(domains): continuation.resume(returning: domains)
        case let .failure(error): continuation.resume(throwing: error)
      }
    }
  })
}

Task {
  do {
    let domains = try await fetchDomainsWithUnsafeThrowingContinuation(for: url)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

func fetchDomainsWithCheckedThrowingContinuation(for url: URL) async throws -> Domains {
  try await withCheckedThrowingContinuation({continuation in
    fetchDomains(for: url) {result in
      switch result {
        case let .success(domains): continuation.resume(returning: domains)
        case let .failure(error): continuation.resume(throwing: error)
      }
    }
  })
}

Task {
  do {
    let domains = try await fetchDomainsWithCheckedThrowingContinuation(for: url)
    for domain in domains.data {
      let attributes = domain.attributes
      print("\(attributes.name): \(attributes.description) - \(attributes.level)")
    }
  } catch {
    print(error)
  }
}

actor Playlist {
  let title: String
  let author: String
  private var songs: [String]
  
  init(title: String, author: String, songs: [String]) {
    self.title = title
    self.author = author
    self.songs = songs
  }
  
  private func add(song: String) {
    songs.append(song)
  }
  
  private func remove(song: String) {
    guard !songs.isEmpty, let index = songs.firstIndex(of: song) else {return}
    songs.remove(at: index)
  }
  
  func transfer(song: String, from playlist: isolated Playlist) {
    playlist.remove(song: song)
    add(song: song)
  }
  
  func move(song: String, to playlist: isolated Playlist) {
    remove(song: song)
    playlist.add(song: song)
  }
}

let favoritePlaylist = Playlist(title: "Favorite songs", author: "Cosmin", songs: ["Nothing else matters"])
let partyPlaylist = Playlist(title: "Party songs", author: "Ray", songs: ["Stairway to heaven"])

/*
Task {
  await favoritePlaylist.transfer(song: "Stairway to heaven", from: partyPlaylist)
  await favoritePlaylist.move(song: "Nothing else matters", to: partyPlaylist)
}
*/

//Warning: The commented asynchronous code only works in projects.

extension Playlist: CustomStringConvertible {
  nonisolated var description: String {
    "\(title) by \(author)."
  }
}

print(favoritePlaylist)

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
  let first = Int.random(in: 1...10)
  let second = Int.random(in: 1...10)
  let number = Int.random(in: min(first, second)...max(first, second))
  print(number)
}

execute(task: showRandomNumber)

