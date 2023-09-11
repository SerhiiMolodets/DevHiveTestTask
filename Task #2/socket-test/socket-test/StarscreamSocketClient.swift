//
//  SocketClient.swift
//  socket-test
//
//  Created by Serhii Molodets on 11.09.2023.
//
import Foundation
import Starscream


class StarscreamSocketClient {
    private var socket: WebSocket?
    var isConnected = false
    
    func connectToServer() {
        let wsURL = URL(string: "ws://localhost:8080")!
        var request = URLRequest(url: wsURL)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func sendMessage(_ message: String) {
        socket?.write(string: message)
    }
    
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("WebSocket encountered an error: \(e.message)")
        } else if let e = error {
            print("WebSocket encountered an error: \(e.localizedDescription)")
        } else {
            print("WebSocket encountered an error")
        }
    }
}

extension StarscreamSocketClient: WebSocketDelegate {

    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("WebSocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("WebSocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
            if string == "ping" {
                sendMessage("pong")
            }
        default: break
        }
    }
}


