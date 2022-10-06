//
//  PostsViewModel.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import Foundation
import Combine

// The view model pulls data from the repository and performs whatever transformation is needed to get it prepared for use by the view
// Needs to be an Observable object to interact with SwiftUI
class PostsViewModel: ObservableViewModel {
    @Injected(\.postRepository) private var postRepo: PostRepositoryProtocol
    @Injected(\.userRepository) private var userRepo: UserRepositoryProtocol

    private unowned let coordinator: PostsCoordinator

    init(coordinator: PostsCoordinator) {
        self.coordinator = coordinator
    }

    // Each view state associated with the view Model should be exposed as a published property
    @Published var posts: [PostViewState] = [] {
        didSet {
            contentLoadState = posts.isEmpty ? .noData : .hasData
        }
    }

    override func bindViewModel() {
        super.bindViewModel()

        fetchPosts()
    }

    func showPostDetail(_ postId: Int) {
        coordinator.handleRoute(.post(postId))
    }

    private func fetchPosts() {
        contentLoadState = .loading

        // This view model fetches a list of posts, then a list of users that made those posts,
        // then combines the text and user names into a structure for display
        Task { @MainActor in
            do {
                struct Raw {
                    var posts: [Post]
                    var users: [User]
                }

                async let rawPosts = try postRepo.getPostList(cacheMode: .cacheAndUpdate)
                async let users = try userRepo.getUsers(cacheMode: .cacheAndUpdate)

                let raw = try Raw(posts: await rawPosts, users: await users)
                self.posts = raw.posts.compactMap { post in
                    guard let user = raw.users.first(where: { $0.id == post.userId }) else { return nil }

                    return PostViewState(id: post.id, text: post.title, user: user.name )
                }
            } catch {
                errorService.error.send(error)
            }
        }
    }
}
