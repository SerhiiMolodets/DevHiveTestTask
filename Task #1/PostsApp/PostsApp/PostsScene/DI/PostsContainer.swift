//
//  PostsContainer.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation

import Swinject

extension Container {
    static let network: Container = {
        let container = Container()
        container.register(PostNetworkServiceProtocol.self) { _ in
            PostNetworkService()
        }
        return container
    }()
    
    static let postData: Container = {
        let container = Container()
        container.register(PostsDataServiceProtocol.self) { _ in
            DataService()
        }
        return container
    }()
    
    static let listViewModel: Container = {
        let container = Container()
        container.register(ListViewModelProtocol.self) { _ in
            ListViewModel()
        }
        return container
    }()
    
    static let comentsViewModel: Container = {
        let container = Container()
        container.register(CommentsViewModelProtocol.self) { _ in
            CommentsViewModel()
        }
        return container
    }()
    
    static let commentsData: Container = {
        let container = Container()
        container.register(CommentsDataServiceProtocol.self) { _ in
            DataService()
        }
        return container
    }()
}
