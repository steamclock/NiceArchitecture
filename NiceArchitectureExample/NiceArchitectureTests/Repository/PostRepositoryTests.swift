//
//  PostRepositoryTests.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Combine
@testable import NiceArchitectureExample
import XCTest

class PostRepositoryTests: XCTestCase {
    var postRepository: PostRepository!
    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()

        InjectedValues[\.postService] = MockPostService()
        postRepository = PostRepository()
    }


    func testShouldPassthroughGetPost() {
        let expectation = XCTestExpectation(description: "Post should be passed through")

        postRepository.post
            .sink { post in
                expectation.fulfill()
            }.store(in: &cancellables)

        Task {
            let post = try? await postRepository.getPost(id: "1", cacheMode: .cacheAndUpdate)

            XCTAssertNotNil(post)
        }

        wait(for: [expectation], timeout: 1.0)

        XCTAssert(true)
    }

    func testShouldPassthroughGetPostList() {
        let expectation = XCTestExpectation(description: "Posts should be passed through")

        postRepository.postList
            .sink { post in
                expectation.fulfill()
            }.store(in: &cancellables)

        Task {
            let post = try? await postRepository.getPostList(cacheMode: .cacheAndUpdate)

            XCTAssertNotNil(post)
        }

        wait(for: [expectation], timeout: 1.0)

        XCTAssert(true)
    }
}
