//
//  PostsNetworkService.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

protocol PostNetworkServiceProtocol {
    func getUsers() async throws -> [User]
    func getComments() async throws -> [Comment]
    func getPosts() async throws -> [Post]
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
    func getComments() async throws -> [Comment] {
        do {
            return try await sendRequest(
                endpoint: PostsEndpoint.comments,
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
    
    func getPosts() async throws -> [Post] {
        do {
            return try await sendRequest(
                endpoint: PostsEndpoint.posts,
                useCache: true,
                decoder: decoder
            )
        } catch {
            throw error
        }
    }
}
