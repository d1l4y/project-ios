//
//  UserDetailsViewModel.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import Foundation

protocol UserDetailsViewModelProtocol {
    var user: User { get }
    var repos: [Repository] { get }
}

class UserDetailsViewModel: UserDetailsViewModelProtocol {
    var user: User
    var repos: [Repository]
    
    init(user: User, repos: [Repository]) {
        self.user = user
        self.repos = repos
    }
}
