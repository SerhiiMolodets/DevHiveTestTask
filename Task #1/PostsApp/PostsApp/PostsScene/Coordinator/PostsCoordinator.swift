//
//  PostsCoordinator.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation
import UIKit
import Swinject
import RxSwift

final class PostsCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    private let bag = DisposeBag()
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = Container.listViewModel.resolve(ListViewModelProtocol.self)
        let viewController = ListViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel?.showComments.asObservable()
            .subscribe { [weak self] id in
                self?.showComments(for: id)
            }.disposed(by: bag)
    }
    
    
    private func showComments(for postID: Int) {
        navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let viewModel = Container.comentsViewModel.resolve(CommentsViewModelProtocol.self)
        viewModel?.currentPostId.accept(postID)
        let viewController = CommentsViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
