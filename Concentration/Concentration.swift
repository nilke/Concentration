//
//  Concentration.swift
//  Concentration
//
//  Created by Nils on 2019-01-19.
//  Copyright © 2019 Nils. All rights reserved.
//

import Foundation

struct Concentration
{
    
   private(set) var cards = [Card]()
    private var randomCards = [Card()]
    var flipCount = 0
    var gameScore = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly //Filter loops through an array, $0 is the index of the array it loops through, in this case the index of indices
           // return cards.indices.filter({(index: Int) -> Bool in return cards[index].isFaceUp}).oneAndOnly < - Long syntax

        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCards(at: \(index)): choosen index not in cards ")

        flipCount += 1
        if !cards[index].isMatched{ // Make sure to not act on matched cards (transparent)
            if let matchindex = indexOfOneAndOnlyFaceUpCard, matchindex != index{ // If the indexofone... is not nil jump into the loop, not nil means there is another card open
                if cards[matchindex].identifier == cards[index].identifier{ //if the last cards identifier is equal to this selected card then:
                    cards[matchindex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                } else { //if second cards is different (no match)
                    if cards[index].isSeen{
                        gameScore += -1
                    }
                }
                cards[index].isFaceUp = true
            } else { //This is the first card opened
                if cards[index].isSeen{
                    gameScore += -1
                }
                cards[index].isSeen = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int ) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card] //+= appends the array cards, since card is a strcuts it gets copied to the array
        }
        
        // Shuffle the deck
//        randomCards = cards
//        for index in cards.indices{
//            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
//            randomCards [index] = cards.remove(at: randomIndex)
//            // randomCards += cards[randomIndex]
//        }
//        cards = randomCards
//        print(cards)
    }
}


extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
