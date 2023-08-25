//
//  UserListViewModelTests.swift
//  Verity iOSTests
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import XCTest
@testable import Verity_iOS

class UserListViewModelTests: XCTestCase {

    var sut: UserListViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UserListViewModel(requestHandler: MockValidRequestHandler())
        
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetUsersListSuccess() throws {
        let expectation = XCTestExpectation(description: "Waiting for users list")

        sut?.didUpdateUsersList = { [self] in
            XCTAssertEqual(sut?.users.count, 3, "Number of users should be 3")
            expectation.fulfill()
        }
        sut?.getUsersList()

        wait(for: [expectation], timeout: 3)
    }
    
    func testGetUsersDetailsSuccess() throws {
        let expectation = XCTestExpectation(description: "Waiting for users details")

        sut?.didReceiveUserDetails = { userDetails, repositories in
            XCTAssertNotNil(userDetails)
            XCTAssertEqual(repositories.count, 2, "Number of repositories should be 2")
            expectation.fulfill()
        }
        sut?.getUserDetails(user: "test")

        wait(for: [expectation], timeout: 3)
    }

    func testGetUsersListError() throws {
        let expectation = XCTestExpectation(description: "Waiting for users list error")

        sut = UserListViewModel(requestHandler: MockInvalidRequestHandler())
        var showErrorCalled: Bool = false

        sut?.showRequestError = { [self] requestError in
            XCTAssertEqual(sut?.users.count, 0, "Number of users should be 0")
            XCTAssertTrue(requestError.type == .unknownError, "RequestErrorType should be unknownError")
            showErrorCalled = true
            expectation.fulfill()
        }
        sut?.getUsersList()
        
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(showErrorCalled, "showRequestError should be called")
    }
    
    func testGetUsersDetailsError() throws {
        let expectation = XCTestExpectation(description: "Waiting for user details error")
        sut = UserListViewModel(requestHandler: MockInvalidRequestHandler())
        var showErrorCalled: Bool = false
        
        sut?.showRequestError = { requestError in
            XCTAssertTrue(requestError.type == .unknownError, "RequestErrorType should be unknownError")
            showErrorCalled = true
            expectation.fulfill()
        }
        sut?.getUserDetails(user: "test")
        
        wait(for: [expectation], timeout: 3)
        XCTAssertTrue(showErrorCalled, "showRequestError should be called")
    }
    
    
    func testIfShouldFetchIsRespected() throws {
        sut?.updateShouldFetch(to: false)
        sut?.getUsersList()

        XCTAssertEqual(sut?.users.isEmpty, true, "shouldFetch flag should be respected for users list")
    }

}
