//
//  PostsEndpoint.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

enum PostsEndpoint: Endpoint {
    
    case users
    case posts
    case comments
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case .posts:
            return "/posts"
        case .comments:
            return "/comments"
        }
    }
    var method: RequestMethod {
        switch self {
        case .users, .posts, .comments:
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
        return nil
    }
    
}
