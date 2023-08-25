//
//  ApiRoute.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import Foundation

enum APIRoute {
    case getUsersList(pagination: Int)
    case getUserDetails(user: String)
    case getUserRepositories(user: String)
    
    private var baseURLString: String { "https://api.github.com" }
    
    private var url: URL? {
        switch self {
        case .getUsersList(let pagination):
            return URL(string: baseURLString + "/users?per_page=\(pagination)")
            
        case .getUserDetails(let user):
            return URL(string: baseURLString + "/users/\(user)")
        case .getUserRepositories(let user):
            return URL(string: baseURLString + "/users/\(user)/repos")
        }
    }

    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        guard let parametrizedURL = components?.url else {
            preconditionFailure("Missing URL with parameters for url: \(url)")
        }
        
        return URLRequest(url: parametrizedURL)
    }
}
