//
//  MockRequestHandler.swift
//  Verity iOSTests
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import XCTest
@testable import Verity_iOS

class MockValidRequestHandler: RequestHandlerProtocol {
    func fetchUserDetails(user: String, completion: @escaping (Result<Verity_iOS.User, Verity_iOS.RequestError>) -> Void) {
        let userDetails: User = User(name: "userTest",
                                     twitter_username: "userTest",
                                     bio: "bio test",
                                     company: "test company",
                                     followers: 100,
                                     following: 100,
                                     blog: "blog.test.com",
                                     location: "test location")
        
        completion(.success(userDetails))
    }
    
    func fetchUsersList(pagination: Int, completion: @escaping (Result<[Verity_iOS.User], Verity_iOS.RequestError>) -> Void) {
        let userDetails: [User] = [User(name: "userTest",
                                      twitter_username: "userTest",
                                      bio: "bio test",
                                      company: "test company",
                                      followers: 100,
                                      following: 100,
                                      blog: "blog.test.com",
                                      location: "test location"),
                                 User(name: "userTest 2",
                                      twitter_username: "userTest",
                                      bio: "bio test",
                                      company: "test company",
                                      followers: 100,
                                      following: 100,
                                      blog: "blog.test.com",
                                      location: "test location"),
                                 User(name: "userTest 3",
                                      twitter_username: "userTest",
                                      bio: "bio test",
                                      company: "test company",
                                      followers: 100,
                                      following: 100,
                                      blog: "blog.test.com",
                                      location: "test location"),
        ]
        completion(.success(userDetails))
    }
    
    func fetchUserRepo(user: String, completion: @escaping (Result<[Verity_iOS.Repository], Verity_iOS.RequestError>) -> Void) {
        let repositories: [Repository] = [Repository(name: "test repo",
                                                     description: "test description",
                                                     id: 10,
                                                     visibility: "public",
                                                     html_url: "test.com",
                                                     updated_at: "2018-02-18T21:02:41Z",
                                                     stargazers_count: 30,
                                                     language: "Swift"),
                                          Repository(name: "test repo 2",
                                                     description: "test description 2",
                                                     id: 11,
                                                     visibility: "public",
                                                     html_url: "test2.com",
                                                     updated_at: "2018-02-18T21:02:41Z",
                                                     stargazers_count: 20,
                                                     language: "Swift")
        ]
        completion(.success(repositories))
    }
}

class MockInvalidRequestHandler: RequestHandlerProtocol {
    func fetchUserDetails(user: String, completion: @escaping (Result<Verity_iOS.User, Verity_iOS.RequestError>) -> Void) {
        completion(.failure(RequestError(type: .unknownError)))
    }
    
    func fetchUsersList(pagination: Int, completion: @escaping (Result<[Verity_iOS.User], Verity_iOS.RequestError>) -> Void) {
        completion(.failure(RequestError(type: .unknownError)))
    }
    
    func fetchUserRepo(user: String, completion: @escaping (Result<[Verity_iOS.Repository], Verity_iOS.RequestError>) -> Void) {
        completion(.failure(RequestError(type: .unknownError)))
    }
}
