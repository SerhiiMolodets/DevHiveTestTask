//
//  PostsEndpoint.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

enum PostsEndpoint: Endpoint {
    
    case users
    case listBy(id: Int)
    case commentsBy(id: Int)
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case .listBy:
            return "/posts"
        case .commentsBy:
            return "/comments"
        }
    }
    var method: RequestMethod {
        switch self {
        case .users, .listBy, .commentsBy:
            return .get
        }
    }
    var header: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .users: return nil
        case .commentsBy(id: let id): return [URLQueryItem(name: "postId", value: "\(id)")]
        case .listBy(id: let id): return [URLQueryItem(name: "userId", value: "\(id)")]
            
        }
    }

}
