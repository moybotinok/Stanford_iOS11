//
//  Concentration.swift
//  Concentration
//
//  Created by Таня Паушкина on 05.05.2018.
//  Copyright © 2018 tany. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if (cards[index]).isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    init(numberOfPairsOfCard: Int) {
        assert(numberOfPairsOfCard > 0, "Concentration.init(\(numberOfPairsOfCard)): you most have pair of cards")

        for _ in 1...numberOfPairsOfCard {
            
            let card = Card()
            //card - структура, происходит копирование
            cards += [card, card]
            
        }
        //TODO: shuffle the cards
        cards = shuffleArray(cards) as! [Card]
        
    }
    
    private func shuffleArray(_ array: [Any]) -> [Any] {
    
        var result = array
        for index in 0..<result.count - 1 {
            
            let exchangeIndex = Int(arc4random_uniform(UInt32(array.count - index))) + index
            
            let element = result[index]
            result[index] = result[exchangeIndex];
            result[exchangeIndex] = element
            
        }
        
        return result
    }
    
    func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        
        if cards[index].isMatched {
            return
        }
        
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            //check if card match
            
            if cards[matchIndex].identifier == cards[index].identifier {
                
                cards[matchIndex].isMatched = true;
                cards[index].isMatched = true;
            }
            
            cards[index].isFaceUp = true
            
        } else {
            // either no cards or 2 cards are face up
            indexOfOneAndOnlyFaceUpCard = index
            
        }
        
    }
    
}
