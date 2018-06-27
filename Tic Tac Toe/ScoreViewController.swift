//
//  ScoreViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 25/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var OfflineO: UILabel!
    @IBOutlet weak var OfflineX: UILabel!
    @IBOutlet weak var OfflineNul: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = UserDefaults.standard
        OfflineO.text = String(userDefaults.integer(forKey: "OfflineO"))
        OfflineX.text = String(userDefaults.integer(forKey: "OfflineX"))
        OfflineNul.text = String(userDefaults.integer(forKey: "OfflineNul"))
    }
}
