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
        testMessages()
        
        // MARK: - The second way using native
        //        secondSocket.start()
        
    }
    private func testMessages() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.starscreamSocketClient.sendMessage("test \(Int.random(in: 0...1000))")
            self?.testMessages()
        }
        
    }
    
    
    
    
}

