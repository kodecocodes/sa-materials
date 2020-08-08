//: [Previous](@previous)

import Foundation

protocol GraphNode {
  var connectedNodes: [GraphNode] { get set }
}

//protocol Matryoshka {
//  var inside: Matryoshka? { get set }
//}
//
//class HandCraftedMatryoshka: Matryoshka {
//  var inside: Matryoshka?
//}
//
//class MachineCraftedMatryoshka: Matryoshka {
//  var inside: Matryoshka?
//}

protocol Matryoshka: AnyObject {
  var inside: Self? { get set }
}

final class HandCraftedMatryoshka: Matryoshka {
  var inside: HandCraftedMatryoshka?
}

final class MachineCraftedMatryoshka: Matryoshka {
  var inside: MachineCraftedMatryoshka?
}

var handMadeDoll = HandCraftedMatryoshka()
var machineMadeDoll = MachineCraftedMatryoshka()
//handMadeDoll.inside = machineMadeDoll // error

//var list: [Matryoshka] = [] // error
