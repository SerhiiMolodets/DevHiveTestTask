//
//  PostsNetworkService.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

protocol PostNetworkServiceProtocol {
    func getUsers() async throws -> [User]
    func getComments(by id: Int) async throws -> [Comment]
    func getPosts(by userId: Int) async throws -> [Post]
}

struct PostNetworkService: HTTPClient, PostNetworkServiceProtocol {

    private let decoder: JSONDecoder = {
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())
    
    func getUsers() async throws -> [User] {
        do {
            return try await sendRequest(
                endpoint: PostsEndpoint.users,
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
    func getComments(by id: Int) async throws -> [Comment] {
        do {
            return try await sendRequest(
                endpoint: PostsEndpoint.commentsBy(id: id),
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
    
    func getPosts(by userId: Int) async throws -> [Post] {
        do {
            return try await sendRequest(
                endpoint: PostsEndpoint.listBy(id: userId),
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
}
