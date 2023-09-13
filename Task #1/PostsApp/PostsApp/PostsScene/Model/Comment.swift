//
//  Comment.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation
import RealmSwift

final class Comment: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var postId: Int
    @Persisted var name: String
    @Persisted var  email: String
    @Persisted var  body: String
}
