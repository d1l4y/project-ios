//
//  UserListViewModel.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 23/08/23.
//

import UIKit

protocol UserListViewModelProtocol {
    var users: [User] { get }
    
    var didUpdateUsersList: (() -> Void)? { get set }
    var didReceiveUserDetails: ((User, [Repository]) -> Void)? { get set }
    var showRequestError: ((RequestError) -> Void)?  { get set }
    
    var presentLoadingView: (() -> Void)? { get set }
    var removeLoadingView: (() -> Void)? { get set }
    
    func getUsersList()
    func getUserDetails(user: String)
    func updateShouldFetch(to shouldFetch: Bool)
}

class UserListViewModel: UserListViewModelProtocol {
    var users: [User] = []
    
    var didUpdateUsersList: (() -> Void)?
    var didReceiveUserDetails: ((User, [Repository]) -> Void)?
    var showRequestError: ((RequestError) -> Void)?
    
    var presentLoadingView: (() -> Void)?
    var removeLoadingView: (() -> Void)?
    
    let requestHandler: RequestHandlerProtocol
    
    private var pagination: Int = 24
    private var shouldFetch: Bool = true

    init(requestHandler: RequestHandlerProtocol) {
        self.requestHandler = requestHandler
    }
    
    func getUsersList() {
        guard shouldFetch, pagination < 65 else { return }
        shouldFetch = false
        self.presentLoadingView?()
        
        requestHandler.fetchUsersList(pagination: pagination, completion: { [weak self] result in
            guard let self else { return }
            self.removeLoadingView?()

            self.shouldFetch = true
            switch result {
            case .success(let users):
                self.users = users
                self.updatePagination()
                self.didUpdateUsersList?()
            case .failure(let error):
                self.showRequestError?(error)
            }
        })
    }

    func getUserDetails(user: String) {
        var userDetails: User?
        var userDetailsRepositories: [Repository] = []
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        self.presentLoadingView?()
        
        requestHandler.fetchUserDetails(user: user, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                userDetails = user
                group.leave()
            case .failure(let error):
                self.showRequestError?(error)
            }
        })
        
        requestHandler.fetchUserRepo(user: user, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let repositories):
                group.leave()
                userDetailsRepositories = repositories
            case .failure(let error):
                self.showRequestError?(error)
            }
        })
        
        group.notify(queue: .main, execute: {
            self.removeLoadingView?()
            if let userDetails = userDetails {
                self.didReceiveUserDetails?(userDetails, userDetailsRepositories)
            }
        })
    }
    
    private func updatePagination() {
        pagination += 12
    }
    
    func updateShouldFetch(to shouldFetch: Bool) {
        self.shouldFetch = shouldFetch
    }
}
