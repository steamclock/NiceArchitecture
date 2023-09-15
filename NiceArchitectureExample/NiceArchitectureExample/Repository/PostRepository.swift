//
//  PostRepository.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Combine
import Foundation
import NiceArchitecture

/// Defining an InjectionKey and injecting a currentValue allows us to swap the repository
/// out for a mocked version while testing. See NiceArchitectureTests for more info.
struct PostRepositoryKey: InjectionKey {
    static var currentValue: PostRepositoryProtocol = PostRepository(cache: CacheService())
}

/// Creating a protocol to accompany your repositories is important for testing
/// to ensure that your mocked repositories keep the same behaviour as the real ones.
protocol PostRepositoryProtocol {
    /// We provide a PassthroughSubject for ViewModels to observe changes in our data
    /// in addition to returning the result directly from the `get` calls to provide
    /// flexibility in how updates are consumed.
    var post: PassthroughSubject<Post, Never> { get set }
    var postList: PassthroughSubject<[Post], Never> { get set }

    @discardableResult func getPost(id: Int, cacheMode: CacheMode) async throws -> Post
    @discardableResult func getPostList(cacheMode: CacheMode) async throws -> [Post]
    func deletePost(id: Int) async throws
}

/// Repositories serve as bridges between ViewModels and Services.
/// They are responsible for collecting data from Services, cacheing that information when needed,
/// and passing the ViewState back into the ViewModels.
/// They are also responsible for communicating changes in data and state between ViewModels
/// by publishing changes to the data as it happens.
class PostRepository: PostRepositoryProtocol {
    @Injected(\.postService) private var postService: PostServiceProtocol

    private enum CacheKeys {
        static let postList = CacheKey<[Post]>(key: "PostList")
    }

    private let cache: CacheService

    var post = PassthroughSubject<Post, Never>()
    var postList = PassthroughSubject<[Post], Never>()

    init(cache: CacheService) {
        self.cache = cache
    }

    @discardableResult func getPost(id: Int, cacheMode: CacheMode) async throws -> Post {
        let key = CacheKey<Post>(key: id)
        if let cached = await cache.retrieve(key: key, cacheMode: cacheMode) {
            self.post.send(cached.result)
            if cached.shouldExit { return cached.result }
        }

        let post = try await postService.getPost(id: id)
        await cache.update(key: key, value: post)
        self.post.send(post)
        return post
    }

    @discardableResult func getPostList(cacheMode: CacheMode) async throws -> [Post] {
        let key = CacheKeys.postList
        if let cached = await cache.retrieve(key: key, cacheMode: cacheMode) {
            self.postList.send(cached.result)
            if cached.shouldExit { return cached.result }
        }

        let newPosts = try await postService.getPosts()
        await cache.updateRequest(key: key, values: newPosts)
        self.postList.send(newPosts)
        return newPosts
    }
    
    func deletePost(id: Int) async throws {
        /// TODO
    }
}
