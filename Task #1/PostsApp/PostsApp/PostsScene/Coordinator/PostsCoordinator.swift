//
//  PostsCoordinator.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import Foundation
import UIKit
import Swinject

final class FeedCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = Container.listViewModel.resolve(ListViewModelProtocol.self)
        let viewController = ListViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    private func openDetail() {
    }
}
