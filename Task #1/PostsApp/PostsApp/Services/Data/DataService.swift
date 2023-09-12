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
    func getPosts() async throws -> [Post]
}

protocol CommentsDataServiceProtocol {
    func getComments() async throws -> [Comment]
}

class DataService: PostsDataServiceProtocol, CommentsDataServiceProtocol {
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
    
    func getPosts() async throws -> [Post] {
        do {
            if let posts = try await networkService?.getPosts() {
                return posts
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
    
    func getComments() async throws -> [Comment] {
        do {
            if let comments = try await networkService?.getComments() {
                return comments
            } else {
                return []
            }
        } catch {
            throw error
        }
    }
}
