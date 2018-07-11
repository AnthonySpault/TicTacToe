//
//  MainOnlineViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 27/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//
import Foundation
import UIKit

class MainOnlineViewController: UIViewController {
    
    var username = UserDefaults.standard.string(forKey: "username")
    
    @IBOutlet weak var onlinePlayButtonOutlet: UIButton!
    @IBOutlet weak var pseudo: UILabel!
    @IBAction func onlinePlayButtonAction(_ sender: UIButton) {
        self.onlinePlayButtonOutlet.loadingIndicator(true)
        self.onlinePlayButtonOutlet.setTitle("", for: .normal)
        TTTSocket.sharedInstance.socket.emit("join_queue", username!)
    }
    @IBAction func editUsername(_ sender: Any) {
        let alert = UIAlertController(title: "Votre pseudo", message: "Votre pseudo sera affiché à l'autre joueur", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Toto"
            textField.text = self.username
        }
        alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { [weak alert] (_) in
            UserDefaults.standard.set(alert?.textFields![0].text, forKey: "username")
            self.username = alert?.textFields![0].text
            self.pseudo.text = alert?.textFields![0].text
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onlinePlayButtonOutlet.layer.cornerRadius = 8
        onlinePlayButtonOutlet.loadingIndicator(false)
        onlinePlayButtonOutlet.setTitle("Jouer en Ligne", for: .normal)
        
        
        if (username == nil || username == "") {
            let alert = UIAlertController(title: "Votre pseudo", message: "Votre pseudo sera affiché à l'autre joueur", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Toto"
            }
            alert.addAction(UIAlertAction(title: "Valider", style: .default, handler: { [weak alert] (_) in
                UserDefaults.standard.set(alert?.textFields![0].text, forKey: "username")
                self.username = alert?.textFields![0].text
                self.pseudo.text = alert?.textFields![0].text
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        pseudo.text = self.username
        
        
        
        TTTSocket.sharedInstance.socket.on("join_game") {data, ack in
            self.onlinePlayButtonOutlet.loadingIndicator(false)
            self.onlinePlayButtonOutlet.setTitle("Jouer en Ligne", for: .normal)
            self.performSegue(withIdentifier: "playOnline", sender: data)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "playOnline"){
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! OnlineViewController
            controller.defaultState = sender
        }
    }

}


extension UIButton {
    func loadingIndicator(_ show: Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            //self.alpha = 0.5
            let indicator = UIActivityIndicatorView()
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            //self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
