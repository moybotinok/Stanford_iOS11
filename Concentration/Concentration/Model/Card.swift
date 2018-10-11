//
//  Card.swift
//  Concentration
//
//  Created by Таня Паушкина on 05.05.2018.
//  Copyright © 2018 tany. All rights reserved.
//

import Foundation


struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
    
    //mark: Hashable
    
    var hashValue: Int { return identifier }
    
    //mark: Equatable
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier;
    }
    
}
