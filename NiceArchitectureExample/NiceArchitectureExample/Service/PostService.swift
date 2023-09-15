//
//  PostService.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-08-23.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation
import Netable
import NiceArchitecture

/// Defining an InjectionKey and injecting a currentValue allows us to swap the repository
/// out for a mocked version while testing. See NiceArchitectureTests for more info.
struct PostServiceKey: InjectionKey {
    static var currentValue: PostServiceProtocol = PostService()
}

/// Creating a protocol to accompany your services is important for testing
/// to ensure that your mocked repositories keep the same behaviour as the real ones.
protocol PostServiceProtocol {
    func getPost(id: Int) async throws -> Post
    func getPosts() async throws -> [Post]
    func deletePost(id: String) async throws
}

/// Services are responsible for communicating with external resources.
/// Services should always have minimal internal state - maybe an initial configuration,
/// maybe some ephemeral state like active requests for a network service at most.
/// If it is something that stores a lot of state, it should be in a repository.
/// Our services tend to be fairly lightweight, as most work is done by `Netable`'s `Requests`,
/// including decoding and transforming data provided by the APIs.
/// Using a service here instead of referencing Netable directly from the Repositories
/// gives us an opportunity to compose requests, handle errors, and keep the Repository code
/// a little easier to read, though for some smaller projects may not be strictly necessary.
class PostService: PostServiceProtocol {
    private let netable = Netable(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)

    func getPost(id: Int) async throws -> Post {
        try await netable.request(GetPostRequest(postId: id))
    }

    func getPosts() async throws -> [Post] {
        try await netable.request(GetPostsRequest())
    }

    func deletePost(id: String) async throws {
        // TODO: handle deletion in a separate PR
    }
}
