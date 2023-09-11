//
//  Comment.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

struct Comment: Codable {
    let postId, id: Int
    let name, email, body: String
}
