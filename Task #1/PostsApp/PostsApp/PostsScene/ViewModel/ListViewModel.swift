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
    var currentUser: BehaviorRelay<User> { get }
    var filteredPosts: PublishSubject<[Post]> { get }
    var showComments: PublishSubject<Int> { get }
}

final class ListViewModel: ListViewModelProtocol {
    private let bag = DisposeBag()
    private let dataService: PostsDataServiceProtocol? = Container.postData.resolve(PostsDataServiceProtocol.self)
    let currentUser = BehaviorRelay<User>(value: User())
    let filteredPosts = PublishSubject<[Post]>()
    let showComments = PublishSubject<Int>()
    private  var posts: [Post] = []
    
    init() {
        Task {
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
        currentUser
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] user in
            if let posts = self?.posts.filter({$0.userId == user.id}) {
                DispatchQueue.main.async {
                    self?.filteredPosts.onNext(posts)
                    }
            }
        }.disposed(by: bag)
    }
}
