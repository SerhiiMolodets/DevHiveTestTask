//
//  PostsDataService.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import Swinject

typealias DataServiceProtocol = PostsDataServiceProtocol & CommentsDataServiceProtocol

protocol PostsDataServiceProtocol {
    func getUsers() async throws -> [User]
    func getPosts() async throws -> [Post]
}

protocol CommentsDataServiceProtocol {
    func getComments() async throws -> [Comment]
}

final class DataService: DataServiceProtocol {
    let networkService: PostNetworkServiceProtocol? = Container.network.resolve(PostNetworkServiceProtocol.self)
    let realmService: RealmServiceProtocol? = Container.cache.resolve(RealmServiceProtocol.self)
    
    func getUsers() async throws -> [User] {
        guard let realmService else { return [] }
        do {
            var users: [User] = try await realmService.load()
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
        guard let realmService else { return [] }
        do {
            var posts: [Post] = try await realmService.load()
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
        guard let realmService else { return [] }
        do {
            var comments: [Comment] = try await realmService.load()
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
