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

struct Grade {
  var letter: Character
  var points: Double
  var credits: Double
}

class Person {
  var firstName: String
  var lastName: String
  
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  deinit {
    print("\(firstName) \(lastName) is being removed from memory!")
  }
}

/*
class Student {
  var firstName: String
  var lastName: String
  var grades: [Grade] = []
  
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  func recordGrade(_ grade: Grade) {
    grades.append(grade)
  }
}
*/

class Student: Person {
  weak var partner: Student?
  var grades: [Grade] = []
  
  func recordGrade(_ grade: Grade) {
    grades.append(grade)
  }
 
  deinit {
    print("\(firstName) is being deallocated!")
  }
}

let john = Person(firstName: "Johnny", lastName: "Appleseed")
let jane = Student(firstName: "Jane", lastName: "Appleseed")

john.firstName // "John"
jane.firstName // "Jane"

let history = Grade(letter: "B", points: 9.0, credits: 3.0)
jane.recordGrade(history)
//john.recordGrade(history) // john is not a student!

class BandMember: Student {
  var minimumPracticeTime = 2
}

class OboePlayer: BandMember {
  override var minimumPracticeTime: Int {
    get {
      super.minimumPracticeTime * 2
    }
    set {
      super.minimumPracticeTime = newValue / 2
    }
  }
}

func phonebookName(_ person: Person) -> String {
  "\(person.lastName), \(person.firstName)"
}

let person = Person(firstName: "Johnny", lastName: "Appleseed")
let oboePlayer = OboePlayer(firstName: "Jane", lastName: "Appleseed")

phonebookName(person) // Appleseed, Johnny
phonebookName(oboePlayer) // Appleseed, Jane

var hallMonitor = Student(firstName: "Jill", lastName: "Bananapeel")

hallMonitor = oboePlayer

oboePlayer as Student
//(oboePlayer as Student).minimumPracticeTime // ERROR: No longer a band member!

hallMonitor as? BandMember
(hallMonitor as? BandMember)?.minimumPracticeTime // 4 (optional)

hallMonitor as! BandMember // Careful! Failure would lead to a runtime crash.
(hallMonitor as! BandMember).minimumPracticeTime // 4 (force unwrapped)

if let hallMonitor = hallMonitor as? BandMember {
  print("This hall monitor is a band member and practices at least \(hallMonitor.minimumPracticeTime) hours per week.")
}

func afterClassActivity(for student: Student) -> String {
  "Goes home!"
}

func afterClassActivity(for student: BandMember) -> String {
  "Goes to practice!"
}

afterClassActivity(for: oboePlayer) // Goes to practice!
afterClassActivity(for: oboePlayer as Student) // Goes home!

class StudentAthlete: Student {
  var failedClasses: [Grade] = []
  
  override func recordGrade(_ grade: Grade) {
    super.recordGrade(grade)
    
    if grade.letter == "F" {
      failedClasses.append(grade)
    }
  }
  
  /*
  override func recordGrade(_ grade: Grade) {
    var newFailedClasses: [Grade] = []
    for grade in grades {
      if grade.letter == "F" {
        newFailedClasses.append(grade)
      }
    }
    failedClasses = newFailedClasses
    
    super.recordGrade(grade)
  }
  */
  
  var isEligible: Bool {
    failedClasses.count < 3
  }
}

final class FinalStudent: Person {}
// class FinalStudentAthlete: FinalStudent {}

class AnotherStudent: Person {
  final func recordGrade(_ grade: Grade) {}
}

class AnotherStudentAthlete: AnotherStudent {
  // override func recordGrade(_ grade: Grade) {}
}

class NewStudent {
  let firstName: String
  let lastName: String
  var grades: [Grade] = []
  
  required init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  
  convenience init(transfer: NewStudent) {
    self.init(firstName: transfer.firstName, lastName: transfer.lastName)
  }
  
  func recordGrade(_ grade: Grade) {
    grades.append(grade)
  }
}

class NewStudentAthlete: NewStudent {
  var failedClasses: [Grade] = []
  var sports: [String]
  
  init(firstName: String, lastName: String, sports: [String]) {
    self.sports = sports
    let passGrade = Grade(letter: "P", points: 0.0, credits: 0.0)
    super.init(firstName: firstName, lastName: lastName)
    recordGrade(passGrade)
  }
  
  required init(firstName: String, lastName: String) {
    self.sports = []
    super.init(firstName: firstName, lastName: lastName)
  }
  
  override func recordGrade(_ grade: Grade) {
    super.recordGrade(grade)
    
    if grade.letter == "F" {
      failedClasses.append(grade)
    }
  }
  
  var isEligible: Bool {
    failedClasses.count < 3
  }
}

class Team {
  var players: [StudentAthlete] = []
  
  var isEligible: Bool {
    for player in players {
      if !player.isEligible {
        return false
      }
    }
    return true
  }
}


class Button {
  func press() {}
}

class Image {}

class ImageButton: Button {
  var image: Image
  
  init(image: Image) {
    self.image = image
  }
}

class TextButton: Button {
  var text: String
  
  init(text: String) {
    self.text = text
  }
}

var someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Person object has a reference count of 1 (someone variable)

var anotherSomeone: Person? = someone
// Reference count 2 (someone, anotherSomeone)

var lotsOfPeople = [someone, someone, anotherSomeone, someone]
// Reference count 6 (someone, anotherSomeone, 4 references in lotsOfPeople)

anotherSomeone = nil
// Reference count 5 (someone, 4 references in lotsOfPeople)

lotsOfPeople = []
// Reference count 1 (someone)

someone = Person(firstName: "Johnny", lastName: "Appleseed")
// Reference count 0 for the original Person object!
// Variable someone now references a new object

var alice: Student? = Student(firstName: "Alice", lastName: "Appleseed")
var bob: Student? = Student(firstName: "Bob", lastName: "Appleseed")

alice?.partner = bob
bob?.partner = alice

alice = nil
bob = nil
