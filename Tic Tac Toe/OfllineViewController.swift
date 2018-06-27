//
//  OfllineViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 30/01/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import Foundation
import UIKit

class OfflineViewController: UIViewController {
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    let userDefaults = UserDefaults.standard
    
    var winPossibilities = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 4, 8],
        [2, 4, 6],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
    ]
    var currentGame = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var currentPlayer = 1
    var canPlay = true
    
    func checkGame() {
        for i in 0..<winPossibilities.count {
            let first = currentGame[winPossibilities[i][0]]
            if (first != 0) {
                var result = true
                let current = winPossibilities[i]
                for j in 1..<current.count {
                    if (first != currentGame[winPossibilities[i][j]]) {
                        result = false
                    }
                }
                if (result) {
                    canPlay = false
                    reloadButton.tintColor = nil
                    if (currentPlayer == 1) {
                        resultLabel.text = "Le joueur O a gagné la partie !"
                        userDefaults.set(userDefaults.integer(forKey: "OfflineO") + 1, forKey: "OfflineO")
                    } else {
                        resultLabel.text = "Le joueur X a gagné la partie !"
                        userDefaults.set(userDefaults.integer(forKey: "OfflineX") + 1, forKey: "OfflineX")
                    }
                    for i in 0..<3 {
                        let tmpButton = self.view.viewWithTag(current[i] + 1) as? UIButton
                        tmpButton?.tintColor = UIColor.green
                    }
                    return
                }
            }
        }
        var end = true
        for i in 0..<currentGame.count {
            if (currentGame[i] == 0) {
                end = false
            }
        }
        if (end) {
            canPlay = false
            reloadButton.tintColor = nil
            resultLabel.text = "Match nul !"
            userDefaults.set(userDefaults.integer(forKey: "OfflineNul") + 1, forKey: "OfflineNul")
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let tag = sender.tag;
        
        if (currentGame[tag - 1] == 0 && canPlay) {
            currentGame[tag - 1] = currentPlayer
            if (currentPlayer == 1) {
                sender.setImage(UIImage(named: "O.png"), for: UIControlState.normal)
                checkGame()
                currentPlayer = 2
            } else {
                sender.setImage(UIImage(named: "X.png"), for: UIControlState.normal)
                checkGame()
                currentPlayer = 1
            }
        }
    }
    
    
    @IBAction func reloadGame(_ sender: Any) {
        if (!canPlay) {
            currentGame = [0, 0, 0, 0, 0, 0, 0, 0, 0]
            currentPlayer = 1
            resultLabel.text = ""
            canPlay = true
            reloadButton.tintColor = UIColor.black
            for i in 1..<10 {
                let tmpButton = self.view.viewWithTag(i) as? UIButton
                tmpButton?.setImage(nil, for: UIControlState.normal)
                tmpButton?.tintColor = UIColor.black
            }
        }
    }
}
