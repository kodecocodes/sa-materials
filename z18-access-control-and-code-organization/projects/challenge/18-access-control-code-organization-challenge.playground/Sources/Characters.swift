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

public enum GameCharacterType {
  case giant
  case wizard
  case elf
}

public protocol GameCharacter: AnyObject {
  var name: String { get }
  var hitPoints: Int { get set }
  var attackPoints: Int { get }
}

class Giant: GameCharacter {
  let name = "Giant"
  var hitPoints = 10
  let attackPoints = 3
}

class Wizard: GameCharacter {
  let name = "Wizard"
  var hitPoints = 5
  let attackPoints = 5
}

class Elf: GameCharacter {
  let name = "Elf"
  var hitPoints = 3
  let attackPoints = 10
}

public struct GameCharacterFactory {
  static public func make(ofType type: GameCharacterType) -> GameCharacter {
    switch type {
    case .giant:
      return Giant()
    case .wizard:
      return Wizard()
    case .elf:
      return Elf()
    }
  }
}

public func battle(_ character1: GameCharacter, vs character2: GameCharacter) {
  character2.hitPoints -= character1.attackPoints
  
  if character2.hitPoints <= 0 {
    print("\(character2.name) defeated!")
    return
  }
  
  character1.hitPoints -= character2.attackPoints
  
  if character1.hitPoints <= 0 {
    print("\(character1.name) defeated!")
  } else {
    print("Both players still active!")
  }
}
