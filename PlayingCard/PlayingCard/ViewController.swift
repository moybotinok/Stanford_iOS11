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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

}

