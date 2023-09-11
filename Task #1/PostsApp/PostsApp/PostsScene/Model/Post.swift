//
//  Post.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation

struct Post: Codable {
    let userId, id: Int
    let title, body: String
}
