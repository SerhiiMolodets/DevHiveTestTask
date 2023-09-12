//
//  ViewController.swift
//  PostsApp
//
//  Created by Serhii Molodets on 11.09.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: ListViewModelProtocol?
    var bag = DisposeBag()
    
    // MARK: - Views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindSelectedUser()
        bindTableData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    // MARK: - Flow funcs
    private func setupUI() {
        setupMenuView()
        view.backgroundColor = .black
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableView.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        tableView.separatorColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func setupMenuView() {
        Task {
            guard let users = await viewModel?.getUsers() else { return }
            let newMenuItems =  users.map { user in
                UIAction(title: user.name) { _ in
                    self.viewModel?.currentUser.accept(user)
                }
            }
            let menu = UIMenu(title: "", options: .displayInline, children: newMenuItems)
            let barButtonItem = UIBarButtonItem(image: UIImage(named: "userIcon"), menu: menu)
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    private func bindSelectedUser() {
        viewModel?.currentUser
            .subscribe(onNext: { user in
                DispatchQueue.main.async {
                    self.title = user.name
                }
            }).disposed(by: bag)
    }
    private func bindTableData() {
        guard let viewModel else { return }
        viewModel.filteredPosts
            .bind(to: tableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) { index, element, cell in
                cell.selectionStyle = .none
                cell.configure(with: element)
            }
            .disposed(by: bag)
        
        tableView.rx.modelSelected(Post.self)
            .map { $0.id }
            .bind(to: viewModel.showComments)
            .disposed(by: bag)
    }
}

