//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Tatiana Bocharnikova on 29.08.2018.
//  Copyright © 2018 tany. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        if let cvc = secondaryViewController as? ConcentrationViewController {
            
            if cvc.theme == nil {
                return true
            }
        }
        
        return false
    }
    
    private var splitViewDetailConcentrationController: ConcentrationViewController? {
        
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        
        if let cvc = splitViewDetailConcentrationController {
            
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                
                cvc.theme = theme
            }
            
        } else if let cvc = lastSeguedToConcentrationViewController {
            
            if let themeName = (sender as? UIButton)?.currentTitle,
                let theme = themes[themeName] {
                
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Choose Theme" {
            
            
            if let button = sender as? UIButton,
                let themeName = button.currentTitle,
                let theme = themes[themeName],
                let concentrationVC = segue.destination as? ConcentrationViewController {
                
                concentrationVC.theme = theme
                lastSeguedToConcentrationViewController = concentrationVC
            }
            
        }
    }

}
