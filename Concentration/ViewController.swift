//
//  ViewController.swift
//  Concentration
//
//  Created by Nils on 2019-01-18.
//  Copyright © 2019 Nils. All rights reserved.
//


/*
 Challanges in HomeWork:
 * newGame fucntion repeats initial instansiations leading to duplicated code in that function
 * Should the Model have anything to do with randomizing the theme? The Theme is in the UI but the randomization of the theme could be said to be a model task?
 
 
 */
import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count+1)/2
    }
    
    
    
    @IBOutlet weak private var flipCountLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var theme = [Int: [String]]()
    
    private lazy var emojiChoices = setTheme()
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emojiChoices = setTheme()
        game.flipCount = 0
        emoji = [Card:String]()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("cardo not in ze buttonarray")
        }
    }
    
    private func  setTheme() -> [String] {
        theme[0] = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
        theme[1] = ["🐎", "🦒", "🦔", "🦛", "🦘", "🦡", "🦢", "🐬", "🐖"]
        theme[2] = ["🏀", "🏉", "🏐", "🏑", "🏓", "🎾", "🏏", "🎿", "🛹"]
        theme[3] = ["😀", "😂", "😱", "😆", "😎", "🤤", "😍", "🤓", "😬"]
        theme[4] = ["🐶", "🐱", "🐭", "🐹", "🙀", "🐰", "🦊", "🐻", "🐼"]
        theme[5] = ["🍏", "🍑", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍍"]
        let randomIndex = Int(arc4random_uniform(UInt32(theme.count-1)))
        return theme[randomIndex]!
    }
    
    private func updateViewFromModel(){
       // print(game.cards)
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) // set background color to transparent if card is matched
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.gameScore)"
        
    }
    
    private var emoji = [Card: String]() // short syntax for Dictonary<Int, String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 { // Short syntax for having two if statements in a row. The comma separates the if statements
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "lol"
        // Syntax above is short and common syntax for below. (Retrun one value if value and another if nil
        //if emoji[card.identifier] != nil {
        //    return emoji[card.identifier]!
        //} else {
        //  return "lol"
    }
    
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}

