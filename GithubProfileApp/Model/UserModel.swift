//
//  UserModel.swift
//  GithubProfileApp
//
//  Created by iremt on 31.07.2023.
//

import Foundation

struct UserModel: Decodable {
    
    let login: String
    let bio: String?
    let avatar_url: String?
}


struct UserFollowers: Decodable {
    let login: String
}
