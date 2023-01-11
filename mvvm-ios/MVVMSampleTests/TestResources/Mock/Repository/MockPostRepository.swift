//
//  MockPostRepository.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Combine
import Foundation
import SteamclUtilityBelt
@testable import MVVMSample

class MockPostRepository: PostRepositoryProtocol {
    var post = PassthroughSubject<Post, Never>()
    var postList = PassthroughSubject<[Post], Never>()

    private var posts: [Post]

    init(posts: [Post]) {
        self.posts = posts
    }

    func getPost(id: Int, cacheMode: CacheMode) async throws -> Post {
        posts.first { $0.id == id }!
    }


    func getPostList(cacheMode: CacheMode) async throws -> [Post] {
        posts
    }

    func deletePost(id: Int) async throws {}
}
