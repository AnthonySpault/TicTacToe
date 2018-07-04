//
//  OnlineViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 27/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//
import Foundation
import UIKit

class OnlineViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func buttonPressed(_ sender: UIButton) {
        if (canPlay) {
            let tag = sender.tag - 1
            TTTSocket.sharedInstance.socket.emit("movement", tag)
        } else {
            print("WAIT BITCH");
        }
    }
    @IBOutlet weak var gameInfo: UILabel!
    @IBOutlet weak var currentTurnLabel: UILabel!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    
    var defaultState: Any?
    var canPlay = false
    let user = UserDefaults.standard.string(forKey: "username")
    var me: String?
    var other: String?
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
    var currentGame = ["", "", "", "", "", "", "", "", ""]
    var win = false

    
    func initGame(data: [String: Any]) {
        if (user == (data["playerX"] as! String)) {
            me = "x"
            other = data["playerO"] as? String
            gameInfo.text = "Vous jouez contre " + other!
        } else {
            me = "o"
            other = data["playerX"] as? String
            gameInfo.text = "Vous jouez contre " + other!
        }
        
        if (me == data["currentTurn"] as? String) {
            canPlay = true
            currentTurnLabel.text = "C'est à toi de jouer"
        } else {
            canPlay = false
            currentTurnLabel.text = "C'est à " + other! + " de jouer"
        }
    }
    
    @IBAction func reloadGame(_ sender: UIBarButtonItem) {
        if (win) {
            TTTSocket.sharedInstance.disconnect()
            reloadButton.tintColor = UIColor.black
            for i in 1..<10 {
                let tmpButton = self.view.viewWithTag(i) as? UIButton
                tmpButton?.setImage(nil, for: UIControlState.normal)
                tmpButton?.tintColor = UIColor.black
            }
            gameInfo.text = "Recherche d'un joueur"
            currentTurnLabel.text = "Merci de patienter"
            TTTSocket.sharedInstance.connect()
            TTTSocket.sharedInstance.socket.emit("join_queue", user!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmp = defaultState as! NSArray
        let data = tmp[0] as! [String: Any]
        
        initGame(data: data)
        
        TTTSocket.sharedInstance.socket.on("join_game") {data, ack in
            let tmp = data as NSArray
            let defaultData = tmp[0] as! [String: Any]
            print(data)
            self.initGame(data: defaultData)
        }
        
        TTTSocket.sharedInstance.socket.on("movement") {data, ack in
            let tmp = data as NSArray
            let data = tmp[0] as! [String: Any]
            self.currentGame[(data["index"] as? Int)!] = (data["player_played"] as? String)!
            let buttonTag = (data["index"] as? Int)! + 1
            let button = self.view.viewWithTag(buttonTag) as? UIButton
            var victoryMessage: String
            var color: UIColor
            if (self.me == data["player_played"] as? String) {
                self.canPlay = false
                self.currentTurnLabel.text = "C'est à " + self.other! + " de jouer"
                victoryMessage = "Félicitation vous avez gagné !"
                color = UIColor.green
            } else {
                self.canPlay = true
                self.currentTurnLabel.text = "C'est à toi de jouer"
                victoryMessage = self.other! + " a gagné !"
                color = UIColor.red
            }
            if ("x" == data["player_played"] as? String) {
                button?.setImage(UIImage(named: "X.png"), for: UIControlState.normal)
            } else {
                button?.setImage(UIImage(named: "O.png"), for: UIControlState.normal)
            }
            if (data["win"] as? Int == 1) {
                self.currentTurnLabel.text = victoryMessage
                self.canPlay = false
                
                for i in 0..<self.winPossibilities.count {
                    let first = self.currentGame[self.winPossibilities[i][0]]
                    
                    var result = true
                    let current = self.winPossibilities[i]
                    for j in 1..<current.count {
                        if (first != self.currentGame[self.winPossibilities[i][j]]) {
                            result = false
                        }
                    }
                    if (result) {
                        self.win = true
                        self.reloadButton.tintColor = nil
                        for i in 0..<3 {
                            let tmpButton = self.view.viewWithTag(current[i] + 1) as? UIButton
                            tmpButton?.tintColor = color
                        }
                        return
                    }
                }
            }
        }
    }
}
