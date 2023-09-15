//
//  PostsViewModelTests.swift
//  RidwellTests
//
//  Created by Jennifer Cooper on 2022-04-19.
//

import Combine
@testable import NiceArchitectureExample
import XCTest

class PostsViewModelTests: XCTestCase {
    var viewModel: PostsViewModel!
    var cancellables = Set<AnyCancellable>()

    @TestData("Users") private var users: [User]
    @TestData("Posts") private var posts: [Post]

    override func setUp() {
        super.setUp()

        InjectedValues[\.postRepository] = MockPostRepository(posts: posts)
        InjectedValues[\.userRepository] = MockUserRepository(users: users)

        viewModel = .init()
    }

    func testSuccessfulContentLoadStates() {
        XCTAssertEqual(viewModel.contentLoadState, .noData)

        let expectation = XCTestExpectation(description: "Posts should populate")
        viewModel.$allPosts
            .dropFirst()
            .sink { vm in
                expectation.fulfill()
            }.store(in: &cancellables)

        viewModel.bindViewModel()

        XCTAssertEqual(viewModel.contentLoadState, .loading)

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(viewModel.contentLoadState, .hasData)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
    }
}
