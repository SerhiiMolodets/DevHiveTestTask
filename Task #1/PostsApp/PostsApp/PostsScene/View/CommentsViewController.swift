//
//  CommentsViewController.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import UIKit
import RxCocoa
import RxSwift

class CommentsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: CommentsViewModelProtocol?
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
        bindTableData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Flow funcs
    private func setupUI() {
        self.title = "Comments"
        view.backgroundColor = .black
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
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
    
    private func bindTableData() {
        guard let viewModel else { return }
        viewModel.filteredComments
            .observe(on:MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: CommentCell.identifier, cellType: CommentCell.self)) { index, element, cell in
                cell.selectionStyle = .none
                cell.configure(with: element)
            }
            .disposed(by: bag)
        
        viewModel.filteredComments
            .observe(on:MainScheduler.asyncInstance)
            .subscribe(onNext: { comments in
                    self.title = "Comments (\(comments.count))"
            }).disposed(by: bag)
    }
}
