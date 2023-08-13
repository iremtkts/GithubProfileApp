//
//  ViewController.swift
//  GithubProfileApp
//
//  Created by iremt on 31.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private let githubIconImageView: UIImageView = {
        let githubIconImage = UIImageView()
        githubIconImage.image = UIImage(named: "github.png")
        githubIconImage.translatesAutoresizingMaskIntoConstraints = false
        return githubIconImage
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Github Username"
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.setTitle("Tap", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
    }
    
    // - MARK: View Constraints
    
    func constraints() {
        view.addSubview(githubIconImageView)
        view.addSubview(usernameTextField)
        view.addSubview(sendButton)
        
        
        githubIconImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        githubIconImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        githubIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        usernameTextField.topAnchor.constraint(equalTo: githubIconImageView.bottomAnchor, constant: 30).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        sendButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    
    @objc func buttonTapped(_ sender: Any) {
        if usernameTextField.text != "" {
            let userVC = UserViewController(username: usernameTextField.text)
            self.navigationController?.pushViewController(userVC, animated: true)
        }
        
    }
    
}
