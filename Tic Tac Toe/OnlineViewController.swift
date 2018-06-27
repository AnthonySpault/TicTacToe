//
//  OnlineViewController.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 27/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import UIKit

class OnlineViewController: UIViewController {

    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
