//
//  PostCell.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import UIKit

final class PostCell: UITableViewCell {
    // MARK: - Properties
    static var identifier: String { String(describing: Self.self) }
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    // MARK: - Flow funcs
    func configure(with post: Post) {
        self.setupUI()
        self.titleLabel.text = post.title
        self.postLabel.text = post.body
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(postLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            postLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
