//
//  RepositoryViewController.swift
//  GithubKitSample
//
//  Created by Takashi Kinjo on 30/10/2017.
//  Copyright © 2017 takasfz. All rights reserved.
//

import UIKit
import GithubKit

final class RepositoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate private(set) var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: RepositoryViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerCell(RepositoryViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        let request = UserNodeRequest(id: user.id, after: nil)
        _ = ApiSession.shared.send(request) { [weak self] in
            switch $0 {
            case .success(let value):
                self?.repositories = value.nodes
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(RepositoryViewCell.self, for: indexPath).apply {
            $0.configure(with: repositories[indexPath.row])
        }
    }
}

extension RepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryViewCell.calculateHeight(with: repositories[indexPath.row], and: tableView)
    }
}
