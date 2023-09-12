//
//  CommentCell.swift
//  PostsApp
//
//  Created by Serhii Molodets on 12.09.2023.
//

import UIKit

class CommentCell: UITableViewCell {
        
        static var identifier: String { String(describing: Self.self) }
        
        private let emailLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()
        
        private let commentLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 2
            label.textColor = .white
            label.textAlignment = .left
            return label
        }()

        
        // MARK: - Flow funcs
        func configure(with comment: Comment) {
            self.setupUI()
            self.emailLabel.text = comment.email
            self.commentLabel.text = comment.body
        }
        
        private func setupUI() {
            self.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            contentView.addSubview(emailLabel)
            contentView.addSubview(commentLabel)
            setupConstraints()
            
        }

        private func setupConstraints() {
            NSLayoutConstraint.activate([
                emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                
                commentLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
            
        }

    }



