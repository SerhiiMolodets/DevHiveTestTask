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
    var filteredComments: PublishSubject<[Comment]> { get }
    func getComments() async ->  [Comment] 
}

final class CommentsViewModel: CommentsViewModelProtocol {
    var bag = DisposeBag()
    var dataService: CommentsDataServiceProtocol? = Container.commentsData.resolve(CommentsDataServiceProtocol.self)
    var currentPostId = BehaviorRelay<Int>(value: 1)
    var filteredComments = PublishSubject<[Comment]>()
    var comments: [Comment] = []
    
    init() {
        Task {
            comments = await getComments()
            filterComments()
        }
    }
    
     func getComments() async ->  [Comment] {
        do {
            if let data = try await dataService?.getComments() {

                return data
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }
    
    private func filterComments() {
        currentPostId.subscribe(onNext: { postId in
            let filteredComments = self.comments.filter { $0.postId == postId }
            self.filteredComments.onNext(filteredComments)
        }).disposed(by: bag)
    }
    
}
