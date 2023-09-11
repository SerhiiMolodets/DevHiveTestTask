//
//  PostsDataService.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import Swinject

protocol PostsDataServiceProtocol {
    func getUsers() async throws -> [User]
}

class PostsDataService: PostsDataServiceProtocol {
    let networkService: PostNetworkServiceProtocol? = Container.network.resolve(PostNetworkServiceProtocol.self)
    
    func getUsers() async throws -> [User] {
        do {
            if let users = try await networkService?.getUsers() {
                return users
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
}
