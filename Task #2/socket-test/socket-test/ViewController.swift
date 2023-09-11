//
//  ViewController.swift
//  socket-test
//
//  Created by DevHive.
//

import UIKit
import Starscream

class ViewController: UIViewController {
    let serverManager = WebSocketServerMock()
    var starscreamSocketClient = StarscreamSocketClient()
    var nativeSocketClient = NativeSocketClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? serverManager.startServer()
        
        // MARK: - The first way using third party library
        starscreamSocketClient.connectToServer()
        
        // MARK: - The second way using native
        //        secondSocket.start()
    }
}

