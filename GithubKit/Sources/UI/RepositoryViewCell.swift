//
//  RepositoryViewCell.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import UIKit

public final class RepositoryViewCell: UITableViewCell, Nibable {
    private static let shared = RepositoryViewCell.makeFromNib()
    private static let minimumHeight: CGFloat = 88
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    @IBOutlet weak var languageContentView: UIView!
    @IBOutlet weak var languageColorView: UIView! {
        didSet {
            let size = languageColorView.bounds.size.width
            languageColorView.layer.cornerRadius = size / 4
            languageColorView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var starLabel: UILabel! {
        didSet {
            starLabel.setText(as: .star)
        }
    }
    
    @IBOutlet weak var forkLabel: UILabel! {
        didSet {
            forkLabel.setText(as: .repoForked)
        }
    }
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let descriptionLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    public static func calculateHeight(with repository: Repository, and tableView: UITableView) -> CGFloat {
        shared.configure(with: repository)
        shared.frame.size.width = tableView.bounds.size.width
        shared.layoutIfNeeded()
        shared.repositoryNameLabel.preferredMaxLayoutWidth = shared.repositoryNameLabel.bounds.size.width
        shared.descriptionLabel.preferredMaxLayoutWidth = shared.descriptionLabel.bounds.size.width
        let height = shared.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return max(minimumHeight, height)
    }
    
    public func configure(with repository: Repository) {
        repositoryNameLabel.text = repository.name
        
        languageContentView.isHidden = (repository.language == nil)
        languageLabel.text = repository.language?.name
        languageColorView.backgroundColor = repository.language.map { UIColor(hexString: $0.color) } ?? nil
        
        starCountLabel.text = repository.stargazerCount.truncateString
        forkCountLabel.text = repository.forkCount.truncateString
        
        if repository.introduction?.isEmpty ?? true {
            if stackView.arrangedSubviews.contains(descriptionLabel) {
                stackView.removeArrangedSubview(descriptionLabel)
            }
            descriptionLabel.removeFromSuperview()
        }
        else if !stackView.arrangedSubviews.contains(descriptionLabel) {
            stackView.insertArrangedSubview(descriptionLabel, at: 0)
        }
        descriptionLabel.text = repository.introduction
        
        let updatedAt = DateFormatter.default.string(from: repository.updatedAt)
        updatedAtLabel.text = "Updated on \(updatedAt)"
    }
}
