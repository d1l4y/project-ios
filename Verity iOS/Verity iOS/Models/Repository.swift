//
//  Repository.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import Foundation

struct Repository: Decodable {
    let name: String?
    let description: String?
    let id: Int?
    let visibility: String?
    let html_url: String?
    let updated_at: String?
    let stargazers_count: Int?
    let language: String?
}
