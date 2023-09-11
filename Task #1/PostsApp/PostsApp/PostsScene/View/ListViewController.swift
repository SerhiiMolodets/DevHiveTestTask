//
//  ViewController.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import UIKit
import RxSwift

class ListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ListViewModelProtocol?
    var bag = DisposeBag()
    
    // MARK: - Views
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        view.backgroundColor = .white
    }
    
    // MARK: - Flow funcs
    private func setupUI() {
        setupMenuView()

    }
    
    private func setupMenuView() {
        Task {
            guard let users = await viewModel?.getUsers() else { return }
            let newMenuItems =  users.map { user in
                UIAction(title: user.name) { _ in
                    print(user)
                }
            }
            let menu = UIMenu(title: "Users", options: .displayInline, children: newMenuItems)
            let barButtonItem = UIBarButtonItem(image: UIImage(named: "userIcon"), menu: menu)
            navigationItem.rightBarButtonItem = barButtonItem
        }
        
    }
}

