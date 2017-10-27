//
//  UserViewController.swift
//  GithubKitSample
//
//  Created by Takashi Kinjo on 27/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import UIKit
import GithubKit

final class UserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate private(set) var users: [User] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(UserViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        automaticallyAdjustsScrollViewInsets = false
        
        ApiSession.shared.token = "Your Github Personal Access Token"
        
        let request = SearchUserRequest(query: "takas", after: nil, limit: 50)
        _ = ApiSession.shared.send(request) { [weak self] in
            switch $0 {
            case .success(let value):
                self?.users = value.nodes
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(UserViewCell.self, for: indexPath).apply {
            $0.configure(with: users[indexPath.row])
        }
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = RepositoryViewController(user: users[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserViewCell.calculateHeight(with: users[indexPath.row], and: tableView)
    }
}
