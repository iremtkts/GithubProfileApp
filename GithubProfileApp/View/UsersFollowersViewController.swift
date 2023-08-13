//
//  UsersFollowersViewController.swift
//  GithubProfileApp
//
//  Created by iremt on 31.07.2023.
//

import UIKit

class UsersFollowersViewController: UIViewController {
    
    private var followers: [UserFollowers] = []
    private let followerService = UserService()
    private let username: String?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(username: String?) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addConstraints()
        fetchFollowers()
    }
    
    // - MARK: View Constraint

    func addConstraints() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    // - MARK: Fetch Data
    
    func fetchFollowers() {
        followerService.fetchFollowers(for: username ?? "") { [weak self] result in
            switch result {
            case .success(let followers):
                self?.followers = followers
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch followers \(error)")
            }
        }
    }
    
}

extension UsersFollowersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let follower = followers[indexPath.row]
        cell.textLabel?.text = follower.login
        return cell
        
    }
    
    
}
