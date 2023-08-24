//
//  UserListViewModel.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 23/08/23.
//

import Foundation

protocol UserListViewModelProtocol {
    var users: [User] { get }
}

class UserListViewModel: UserListViewModelProtocol {
    var users: [User] = [User(name: "anotherjeessdfsdfe",
                              twitter_username: "abc",
                              bio: nil,
                              company: "abc",
                              followers: 10,
                              following: 10,
                              blog: "abc",
                              location: "abc"),
                         User(name: "macournoyer",
                              twitter_username: "abc",
                              bio: nil,
                              company: "abc",
                              followers: 1000,
                              following: 1000,
                              blog: "abc",
                              location: "abc"),
                         User(name: "jamesgolick",
                              twitter_username: "abc",
                              bio: nil,
                              company: "abc",
                              followers: 10,
                              following: 10,
                              blog: "abc",
                              location: "abc")
                         
    ]
}
