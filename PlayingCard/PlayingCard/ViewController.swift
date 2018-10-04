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
    
//    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
//        switch sender.state {
//        case .ended:
//            playingCardView.isFaceUp = !playingCardView.isFaceUp
//
//        default: break
//        }
//    }
    
    
    
    @IBOutlet private var cardViews: [PlayingCardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        playingCardView.contentMode = .redraw
//        playingCardView.backgroundColor = UIColor.clear
     
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count+1)/2) {
            
            let card = deck.draw()!
            cards += [card, card]
        }
        
        for cardView in cardViews {
            
            cardView.layer.cornerRadius = 4.0
            cardView.layer.masksToBounds = true
            
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            
            cardBehavior.addItem(cardView)
        }
        
    }

    private var faceUpCardViews: [PlayingCardView] {
        
        return cardViews.filter{ $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: PlayingCardView.bigScale, y: PlayingCardView.bigScale) && $0.alpha == 1 }
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 && faceUpCardViews[0].rank == faceUpCardViews[1].rank && faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    var lastChosenCardView: PlayingCardView?
    
    @objc func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            
            if let choosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count < 2 {
                
                lastChosenCardView = choosenCardView
                
                cardBehavior.removeItem(choosenCardView)
                
                let animationDuration = 0.6
                
                UIView.transition(with: choosenCardView, duration: animationDuration, options: [.transitionFlipFromLeft], animations: {
                    
                    choosenCardView.isFaceUp = !choosenCardView.isFaceUp
                    
                }) { (finished) in
                    
                    let cardsToAnimate = self.faceUpCardViews
                    
                    if (self.faceUpCardViewsMatch) {
                        
                        
                        UIViewPropertyAnimator.runningPropertyAnimator(
                            withDuration: animationDuration,
                            delay: 0,
                            options: [],
                            animations: {
                            
                                cardsToAnimate.forEach {
                                    $0.transform = CGAffineTransform.identity.scaledBy(x: PlayingCardView.bigScale, y: PlayingCardView.bigScale)
                                }
                                
                        }, completion: { (position) in
                            
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: animationDuration,
                                delay: 0,
                                options: [],
                                animations: {
                                    
                                    cardsToAnimate.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                        $0.alpha = 0
                                    }
                                    
                            }, completion: { (position) in
                                
                                cardsToAnimate.forEach {
                                    
                                    $0.isHidden = true
                                    $0.alpha = 1
                                    $0.transform = .identity
                                }
                                
                            })
                            
                        })
                        
                    } else if (cardsToAnimate.count == 2) {
                        
                        if choosenCardView == self.lastChosenCardView {
                            
                            cardsToAnimate.forEach({ cardView in
                                
                                UIView.transition(with: cardView, duration: animationDuration, options: [.transitionFlipFromLeft], animations: {
                                    
                                    cardView.isFaceUp = false
                                    
                                }, completion: { finished in
                                    self.cardBehavior.addItem(cardView)
                                })
                            })
                        }
                    } else {
                        if !choosenCardView.isFaceUp {
                            self.cardBehavior.addItem(choosenCardView)
                        }
                    }
                }
            }
            
            
        default: break
        }
}
    

}

