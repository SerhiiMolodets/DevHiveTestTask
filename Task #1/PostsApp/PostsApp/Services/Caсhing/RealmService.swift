//
//  RealmService.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func save<T: Object>(item: T)
    func load<T: Object>() async throws -> [T]
}
final class RealmService: RealmServiceProtocol {
    
    func save<T: Object>(item: T) {
        Task {
            await MainActor.run {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(item, update: .modified)
                }
            }
        }
    }

    @MainActor
    func load<T: Object>() async throws -> [T] {
        let realm = try await Realm()
        let loaded = Array(realm.objects(T.self))
        return loaded
    }
//
//    @MainActor
//    func loadPosts() async throws -> [Post] {
//        let realm = try await Realm()
//        let posts = Array(realm.objects(Post.self))
//        return posts
//    }
//
//    @MainActor
//    func loadComments() async throws -> [Comment] {
//        let realm = try await Realm()
//        let comments = Array(realm.objects(Comment.self))
//        return comments
//    }
//
}
