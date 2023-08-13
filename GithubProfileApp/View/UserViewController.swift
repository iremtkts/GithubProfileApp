//
//  UserViewController.swift
//  GithubProfileApp
//
//  Created by iremt on 31.07.2023.
//

import UIKit

class UserViewController: UIViewController {
    
    private let userService = UserService()
    
    private let username: String?
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "username label"
        return label
    }()
    
    private let userDescriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "user desc label"
        return label
    }()
    
    private let userImageView: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "image.png")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.setTitle("Show Followers", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
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
 
        view.backgroundColor = .white
        constraints()
        fetchData()
    }
    
    // - MARK: View Constraints
    
    func constraints() {
        view.addSubview(userImageView)
        view.addSubview(usernameLabel)
        view.addSubview(userDescriptionLabel)
        view.addSubview(showButton)
        
        userImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20).isActive = true
        
        userDescriptionLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        userDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        userDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        showButton.topAnchor.constraint(equalTo: userDescriptionLabel.bottomAnchor, constant: 30).isActive = true
        showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    

    @objc func buttonTapped(_ sender: Any){
        let userVC = UsersFollowersViewController(username: usernameLabel.text)
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
    // - MARK: Fetch Data
    
    func fetchData() {
        userService.fetchData(for: username!) { [weak self] result in
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    if let imageUrl = user.avatar_url, let avatarUrl = URL(string: imageUrl) {
                        self?.userImageView.load(url: avatarUrl)
                    }
                    self?.usernameLabel.text = user.login
                    self?.userDescriptionLabel.text = user.bio
                }
            case .failure(let error):
                print("Failed to fetch user data : \(error)")
            }
        }
    }
    

}
