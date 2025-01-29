//
//  UserListAppTests.swift
//  UserListAppTests
//
//  Created by Selçuk İleri on 29.01.2025.
//

import XCTest
@testable import UserListApp

final class UserListAppTests: XCTestCase {

    var viewModel: UserViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = UserViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    /// Users dizisi dolu olduğunda (.success)
    func testFetchUsers_Success(){
        let expectation = XCTestExpectation(description: "Users should be fetched successfully")
        
        viewModel.onUsersFetched = {
            XCTAssertFalse(self.viewModel.users.isEmpty, "Users array shouldn't be empty")
            expectation.fulfill()
        }
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// Users dizisi boş olduğunda (.failure)
    func testFetchUsers_Failure(){
        let expectation = XCTestExpectation(description: "API should return an error")
        
        viewModel.onError = { error in
            XCTAssertNotNil(error, "Users array shouldn't be empty")
            expectation.fulfill()
        }
        /// Başarısız olması için URL'i bozup deneyebiliriz. Ya da başka bir senaryoyla tabii.
        viewModel.fetchUsers()
        wait(for: [expectation], timeout: 5.0)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
