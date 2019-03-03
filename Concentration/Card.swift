//
//  Card.swift
//  Concentration
//
//  Created by Nils on 2019-01-19.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

//Difference struct and Class
//1. Struct - no inheritence
// 2. Value type instead of reference. Copied
struct Card: Hashable
{
    
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var identifier: Int
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
   private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory

    }
     
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
