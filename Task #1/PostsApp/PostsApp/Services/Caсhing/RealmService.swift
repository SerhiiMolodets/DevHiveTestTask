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
    func loadUsers() async throws -> [User]
    func loadPosts() async throws -> [Post]
    func loadComments() async throws -> [Comment] 
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
    func loadUsers() async throws -> [User] {
        let realm = try await Realm()
        let users = Array(realm.objects(User.self))
        return users
    }
    
    @MainActor
    func loadPosts() async throws -> [Post] {
        let realm = try await Realm()
        let posts = Array(realm.objects(Post.self))
        return posts
    }
    
    @MainActor
    func loadComments() async throws -> [Comment] {
        let realm = try await Realm()
        let comments = Array(realm.objects(Comment.self))
        return comments
    }
    
    func cleanAll() {
        DispatchQueue.main.async {
            do {
                   let realm = try Realm()
                   try realm.write {
                       realm.deleteAll()
                   }
               } catch let error {
                   print("Error deleting all wallet models: \(error)")
               }
        }
    }
}
