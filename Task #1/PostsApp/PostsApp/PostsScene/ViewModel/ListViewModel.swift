//
//  ListViewModel.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import RxSwift
import RxRelay
import Swinject

protocol ListViewModelProtocol {
    func getUsers() async -> [User]
    var users: [User] { get set }
    var currentUser: BehaviorRelay<User> { get }
    var filteredPosts: PublishSubject<[Post]> { get }
    var showComments: PublishSubject<Int> { get }
    //    var detailData: DetailPost? { get set }
}

final class ListViewModel: ListViewModelProtocol {
    var bag = DisposeBag()
    var dataService: PostsDataServiceProtocol? = Container.commentsData.resolve(PostsDataServiceProtocol.self)
    var currentUser = BehaviorRelay<User>(value: User(id: 0, name: "", username: ""))
    var filteredPosts = PublishSubject<[Post]>()
    var showComments = PublishSubject<Int>()
    var users: [User] = []
    var posts: [Post] = []
    
    init() {
        Task {
            users = await getUsers()
            posts = await getPosts()
        }
        filterPosts()
    }
    
    func getUsers() async -> [User] {
        do {
            if let data = try await dataService?.getUsers() {
                if let currentUser = data.first(where: { $0.id == 1 }) {
                    self.currentUser.accept(currentUser)
                }
                return data
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }
    
    private func getPosts() async ->  [Post] {
        do {
            if let data = try await dataService?.getPosts() {
                return data
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }
    
    private func filterPosts() {
        currentUser.subscribe { [weak self] user in
            if let posts = self?.posts.filter({$0.userId == user.id}) {
                self?.filteredPosts.onNext(posts)
            }
        }.disposed(by: bag)
    }
    
    
    
}
