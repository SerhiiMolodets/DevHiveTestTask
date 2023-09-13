//
//  Post.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation
import RealmSwift

final class Post: Object, Decodable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var userId: Int
    @Persisted var title: String
    @Persisted var body: String
}
