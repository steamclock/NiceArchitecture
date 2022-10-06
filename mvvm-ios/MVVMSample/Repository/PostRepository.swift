//
//  PostRepository.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import Foundation
import Netable
import Combine

// Should this and the repo protocol live in a separate file?
struct PostRepositoryKey: InjectionKey {
    static var currentValue: PostRepositoryProtocol = PostRepository(cache: CacheService())
}

protocol PostRepositoryProtocol {
    var post: PassthroughSubject<Post, Never> { get set }
    var postList: PassthroughSubject<[Post], Never> { get set }

    @discardableResult func getPost(id: Int, cacheMode: CacheMode) async throws -> Post
    @discardableResult func getPostList(cacheMode: CacheMode) async throws -> [Post]
    func deletePost(id: Int) async throws
}

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
        // TODO
//        deletedPosts.insert(id)
//        cacheService.removeFromCache(key: PostsRepository.postsKey)
//        return fetchPosts(cacheMode: .cacheAndUpdate).setFailureType(to: NetableError.self).eraseToAnyPublisher()
    }
}
