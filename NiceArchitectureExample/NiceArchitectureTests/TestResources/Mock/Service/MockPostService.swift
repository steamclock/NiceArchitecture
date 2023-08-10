//
//  MockPostService.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Foundation
@testable import NiceArchitectureExample

class MockPostService: PostServiceProtocol {
    @TestData("Posts") var posts: [Post]

    func getPost(id: String) async throws -> Post {
        posts.first!
    }

    func getPosts() async throws -> [Post] {
        posts
    }

    func deletePost(id: String) async throws {}
}
