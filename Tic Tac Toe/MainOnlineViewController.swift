//
//  MainOnlineViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 27/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import UIKit

class MainOnlineViewController: UIViewController {

    @IBOutlet weak var onlinePlayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onlinePlayButton.layer.cornerRadius = 8
    }

}
