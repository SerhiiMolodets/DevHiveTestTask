//
//  CommentsViewModel.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import Foundation
import RxSwift
import RxRelay
import Swinject

protocol CommentsViewModelProtocol {
    var currentPostId: BehaviorRelay<Int> { get }
    var filteredComments: PublishSubject<[Post]> { get }
}

final class CommentsViewModel: CommentsViewModelProtocol {
    var dataService: PostsDataServiceProtocol? = Container.commentsData.resolve(PostsDataServiceProtocol.self)
    var currentPostId = BehaviorRelay<Int>(value: 1)
    var filteredComments = PublishSubject<[Post]>()
    var comments: [Comment] = []
    
}
