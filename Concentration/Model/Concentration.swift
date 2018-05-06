//
//  Concentration.swift
//  Concentration
//
//  Created by Таня Паушкина on 05.05.2018.
//  Copyright © 2018 tany. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    init(numberOfPairsOfCard: Int) {
        
        for _ in 1...numberOfPairsOfCard {
            
            let card = Card()
//            card - структура, происходит копирование
//            cards.append(card)
//            cards.append(card)
            cards += [card, card]
            
        }
        //TODO: shuffle the cards
        cards = shuffleArray(cards) as! [Card]
        
    }
    
    func shuffleArray(_ array: [Any]) -> [Any] {
    
        var result = array
        for index in 0..<result.count - 1 {
            
            let exchangeIndex = Int(arc4random_uniform(UInt32(array.count - index))) + index
            
            let element = result[index]
            result[index] = result[exchangeIndex];
            result[exchangeIndex] = element
            
        }
        
        return result
    }
    
    
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        
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
            indexOfOneAndOnlyFaceUpCard = nil
            
        } else {
            // either no cards or 2 cards are face up
            
            for flipDownIndex in cards.indices {
                
                cards[flipDownIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
            
        }
        
    }
    
}
