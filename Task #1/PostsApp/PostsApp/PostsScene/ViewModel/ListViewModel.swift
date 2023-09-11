//
//  ListViewModel.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import RxSwift
import Swinject

protocol ListViewModelProtocol {
    func getUsers() async -> [User]
//    var users: [User]? { get }
//    var openDetail: PublishSubject<Int> { get }
//    var detailData: DetailPost? { get set }
}

final class ListViewModel: ListViewModelProtocol {
    
    var dataService: PostsDataServiceProtocol? = Container.data.resolve(PostsDataServiceProtocol.self)
    
//    init() {
//        Task {
//            await getUsers()
//        }
//    }
    
     func getUsers() async -> [User] {
         var users: [User] = []
        do {
            guard let data = try await dataService?.getUsers() else { return users }
            users = data
        } catch {
            debugPrint(error.localizedDescription)
        }
         return users
    }
    

    
}
