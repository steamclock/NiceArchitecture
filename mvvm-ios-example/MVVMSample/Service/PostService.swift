//
//  PostService.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation
import Netable
import SteamclUtilityBelt

struct PostServiceKey: InjectionKey {
    static var currentValue: PostServiceProtocol = PostService()
}

protocol PostServiceProtocol {
    func getPost(id: Int) async throws -> Post
    func getPosts() async throws -> [Post]
    func deletePost(id: String) async throws
}

// A service is an object that performs some communication or utility function. Services should always have minimal
// internal state (an initial configuration, maybe some ephemeral state like active requests for a network service),
// if it is something that stores a lot of state, it should be in a repository. The structure of the members of a service
// are the least constrained by the overall architecture, since they depend a lot on what the service actually does.
//
// This service is just a super thin wrapper around Netable for demonstration purposes.
//
// In a real app, if the service were really this simple and was only used by one repository, it probably wouldn't make sense for the service and repository
// to be separate classes
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
