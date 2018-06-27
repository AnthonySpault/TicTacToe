//
//  TTTSocket.swift
//  Tic Tac Toe
//
//  Created by Anthony Spault on 27/06/2018.
//  Copyright © 2018 Anthony Spault. All rights reserved.
//

import Foundation
import SocketIO

class TTTSocket {
    static let sharedInstance = TTTSocket()
    let socket = SocketIOClient(socketURL: URL(string: "http://51.254.112.146:5666")!, config: [])
    
    func connect() {
        self.socket.connect()
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
}
