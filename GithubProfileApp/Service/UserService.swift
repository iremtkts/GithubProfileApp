//
//  UserService.swift
//  GithubProfileApp
//
//  Created by iremt on 31.07.2023.
//

import Foundation

class UserService {
    
    //https://api.github.com/users/USERNAME
    
    func fetchData(for username: String, completion: @escaping (Result <UserModel, Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let userResponse = try decoder.decode(UserModel.self, from: data)
                    completion(.success(userResponse))
                }
                catch let error {
                    print("Decoding error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
//https://api.github.com/users/USERNAME/followers
    
    func fetchFollowers(for username: String, completion: @escaping (Result <[UserFollowers], Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/followers") else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let userResponse = try decoder.decode([UserFollowers].self, from: data)
                    completion(.success(userResponse))
                }
                catch let error {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    
}


