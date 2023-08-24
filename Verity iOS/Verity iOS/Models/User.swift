//
//  User.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 23/08/23.
//

import Foundation

struct User: Codable {
    var login: String?
    let name: String?
    var id: Int?
    var avatar_url: String?
    let twitter_username: String?
    let bio: String?
    let company: String?
    let followers: Int?
    let following: Int?
    let blog: String?
    let location: String?
}
