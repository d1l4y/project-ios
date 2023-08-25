//
//  RequestHandlerTests.swift
//  Verity iOSTests
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import XCTest
@testable import Verity_iOS

class RequestHandlerTests: XCTestCase {
    
    var sut: RequestHandler?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RequestHandler()
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAPIFetchUserDetailsSuccess() throws {
        var requestError: RequestError?
        var requestUser: User?
        
        let expectation = XCTestExpectation(description: "Waiting for user details")
        
        sut?.fetchUserDetails(user: "d1l4y", completion: { result in
            switch result {
            case .success(let user):
                requestUser = user
            case .failure(let error):
                requestError = error
            }
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(requestUser?.login == "d1l4y", "API call should search for the correct user")
        XCTAssertTrue(requestError == nil, "RequestError should be nil")
    }
    
    func testAPIFetchUserDetailsUnknownUserReturn() throws {
        var requestError: RequestError?
        var requestUser: User?
        
        let expectation = XCTestExpectation(description: "Waiting for user details")
        
        sut?.fetchUserDetails(user: "*", completion: { result in
            switch result {
            case .success(let user):
                requestUser = user
                print("teste \(user)")
            case .failure(let error):
                requestError = error
                print("teste erro \(error)")

            }
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(requestUser?.login == nil, "user doesn't exist, should be nil")
        XCTAssertTrue(requestError?.type ==  .invalidUser, "request error type should be invalidUser ")
    }
    
    func testAPIFetchUserRepositorySuccess() throws {
        var requestError: RequestError?
        var requestRepositories: [Repository]?
        
        let expectation = XCTestExpectation(description: "Waiting for user details")
        
        sut?.fetchUserRepo(user: "d1l4y", completion: { result in
            switch result {
            case .success(let repositories):
                requestRepositories = repositories
                print("teste \(repositories)")
            case .failure(let error):
                requestError = error
                print("teste erro \(error)")

            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(requestRepositories?.isEmpty == false, "repositories should not be empty")
        XCTAssertTrue(requestError == nil, "RequestError should be nil")
    }
    
    func testAPIFetchUserListSuccess() throws {
        var requestError: RequestError?
        var requestUsers: [User]?
        
        let expectation = XCTestExpectation(description: "Waiting for user details")
        
        sut?.fetchUsersList(pagination: 2, completion: { result in
            switch result {
            case .success(let users):
                requestUsers = users
            case .failure(let error):
                requestError = error
            }
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(requestUsers?.isEmpty == false, "Users list should not be empty")
        XCTAssertTrue(requestError == nil, "RequestError should be nil")
    }

}
