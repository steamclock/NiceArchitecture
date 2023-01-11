//
//  MockPostService.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Foundation
@testable import MVVMSample

class MockPostService: PostServiceProtocol {
    var posts: [Post]

    init() {
        posts = Post.mockedArrayOf(10)
    }

    func getPost(id: Int) async throws -> Post {
        posts.first!
    }

    func getPosts() async throws -> [Post] {
        posts
    }

    func deletePost(id: String) async throws {}
}
