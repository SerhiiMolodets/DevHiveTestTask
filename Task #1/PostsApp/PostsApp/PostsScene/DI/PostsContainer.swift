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
    
    static let data: Container = {
        let container = Container()
        container.register(PostsDataServiceProtocol.self) { _ in
            PostsDataService()
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
}
