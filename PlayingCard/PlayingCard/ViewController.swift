//
//  ViewController.swift
//  PlayingCard
//
//  Created by Tatiana Bocharnikova on 21.08.2018.
//  Copyright © 2018 tany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        
        didSet {
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @objc func nextCard() {
        
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
            
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playingCardView.contentMode = .redraw
        playingCardView.backgroundColor = UIColor.clear
        
    }

}

