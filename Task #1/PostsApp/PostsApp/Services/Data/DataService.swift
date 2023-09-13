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

final class DataService: PostsDataServiceProtocol, CommentsDataServiceProtocol {
    let networkService: PostNetworkServiceProtocol? = Container.network.resolve(PostNetworkServiceProtocol.self)
    let realmService = RealmService()
    
    func getUsers() async throws -> [User] {
        do {
            var users = try await realmService.loadUsers()
            
            if users.isEmpty, let downloaded = try await networkService?.getUsers() {
                downloaded.forEach { realmService.save(item: $0) }
                users = downloaded
            }
            return users
        } catch {
            throw error
        }
    }

    func getPosts() async throws -> [Post] {
        var posts: [Post] = []
        do {
            posts = try await realmService.loadPosts()
            if posts.isEmpty, let downloaded = try await networkService?.getPosts() {
                downloaded.forEach { realmService.save(item: $0) }
                posts = downloaded
            }
            return posts
        } catch {
            throw error
        }
    }
    
    func getComments() async throws -> [Comment] {
        var comments: [Comment] = []
        do {
            comments = try await realmService.loadComments()
            if comments.isEmpty, let downloaded = try await networkService?.getComments() {
                downloaded.forEach { realmService.save(item: $0) }
                comments = downloaded
            }
            return comments
        } catch {
            throw error
        }
    }
}
