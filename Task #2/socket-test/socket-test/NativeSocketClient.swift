//
//  WebSocketClient.swift
//  socket-test
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

class NativeSocketClient: NSObject, URLSessionWebSocketDelegate {
    
    private var session: URLSession { URLSession(configuration: .default,
                                         delegate: self,
                                         delegateQueue: OperationQueue()) }
    
    private var webSocket: URLSessionWebSocketTask?
    
    func start() {
        webSocket = session.webSocketTask(with: URL(string: "ws://localhost:8080")!)
        webSocket?.resume()
    }
    
    func send(message: String) {
            self.webSocket?.send(.string(message),
                            completionHandler: { error in
                if let error {
                    print("send error \(error)")
                }
            })
    }
    
    func receive() {
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("got data \(data)")
                case.string(let message):
                    if message == "ping" {
                        self?.send(message: "pong")
                    }
                    print("message is \(message)")
                @unknown default: break
                }
            case .failure(let error):
                print("receive error \(error)")
            }
            self?.receive()
        })
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        receive()
    }
}
