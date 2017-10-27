//
//  UserViewCell.swift
//  GithubKit
//
//  Created by Takashi Kinjo on 26/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import UIKit
import Nuke

public final class UserViewCell: UITableViewCell, Nibable {
    private static let shared = UserViewCell.makeFromNib()
    private static let minimumHeight: CGFloat = 88
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 4
            thumbnailImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var repositoryLabel: UILabel! {
        didSet {
            repositoryLabel.setText(as: .repo)
        }
    }
    
    @IBOutlet weak var followingLabel: UILabel! {
        didSet {
            followingLabel.setText(as: .eye)
        }
    }
    
    @IBOutlet weak var followerLabel: UILabel! {
        didSet {
            followerLabel.setText(as: .organization)
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoryCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let bioLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    let locationLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 14)
    }
    
    private(set) lazy var locationContentView: UIView = {
        let locationContentView = UIView()
        
        let iconLabel = UILabel().apply {
            $0.setText(as: .location, ofSize: 14)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        locationContentView.addSubview(iconLabel)
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: locationContentView.topAnchor),
            iconLabel.bottomAnchor.constraint(equalTo: locationContentView.bottomAnchor),
            iconLabel.leadingAnchor.constraint(equalTo: locationContentView.leadingAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 14),
        ])
        
        let locationLabel = self.locationLabel.apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        locationContentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationContentView.topAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: locationContentView.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: 4),
            locationLabel.trailingAnchor.constraint(greaterThanOrEqualTo: locationContentView.trailingAnchor, constant: 0),
        ])

        return locationContentView
    }()
    
    public static func calculateHeight(with user: User, and tableView: UITableView) -> CGFloat {
        shared.configure(with: user)
        shared.frame.size.width = tableView.bounds.size.width
        shared.layoutIfNeeded()
        shared.bioLabel.preferredMaxLayoutWidth = shared.bioLabel.bounds.size.width
        let height = shared.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return max(minimumHeight, height)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        Manager.shared.cancelRequest(for: thumbnailImageView)
        thumbnailImageView.image = nil
    }

    public func configure(with user: User) {
        Manager.shared.loadImage(with: user.avatarUrl, into: thumbnailImageView)
        userNameLabel.text = user.login
        repositoryCountLabel.text = user.repositoryCount.truncateString
        followingCountLabel.text = user.followingCount.truncateString
        followerCountLabel.text = user.followerCount.truncateString
        
        if user.location?.isEmpty ?? true {
            if stackView.arrangedSubviews.contains(locationContentView) {
                stackView.removeArrangedSubview(locationContentView)
            }
            locationContentView.removeFromSuperview()
        }
        else if !stackView.arrangedSubviews.contains(locationContentView) {
            stackView.insertArrangedSubview(locationContentView, at: 0)
        }
        locationLabel.text = user.location
        
        if user.bio?.isEmpty ?? true {
            if stackView.arrangedSubviews.contains(bioLabel) {
                stackView.removeArrangedSubview(bioLabel)
            }
            bioLabel.removeFromSuperview()
        }
        else if !stackView.arrangedSubviews.contains(bioLabel) {
            stackView.insertArrangedSubview(bioLabel, at: 0)
        }
        bioLabel.text = user.bio
    }
}
