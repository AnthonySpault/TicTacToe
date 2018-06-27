//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 30/01/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import UIKit

class MainOfflineViewController: UIViewController {

    @IBOutlet weak var offlinePlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offlinePlayButton.layer.cornerRadius = 8
    }

}

