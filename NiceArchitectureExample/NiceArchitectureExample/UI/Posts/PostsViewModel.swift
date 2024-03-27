//
//  PostsViewModel.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Combine
import Foundation
import NiceArchitecture

enum PostsDisplayState: String, CaseIterable {
    case all = "Show All"
    case favourites = "Favourites"
}

/// ViewModels are the workhorses of any MVVM architecture -
/// they're responsible for managing the state for their respective Views by
/// retrieving data from Repositories, capturing and presenting errors,
/// and communicating changes in the presentation state with Coordinators.
class PostsViewModel: ObservableVM {
    @Injected(\.postRepository) private var postRepo: PostRepositoryProtocol
    @Injected(\.userRepository) private var userRepo: UserRepositoryProtocol

    private unowned let coordinator: PostsCoordinator

    init(coordinator: PostsCoordinator) {
        self.coordinator = coordinator
    }

    /// Each ViewState associated with the ViewModel should be exposed as a Published property
    @Published var allPosts: [PostViewState] = []
    @Published var displayState: PostsDisplayState = .all

    var filteredPosts: [PostViewState] {
        switch displayState {
        case .all:
            return allPosts
        case .favourites:
            return allPosts.filter { $0.favourite }
        }
    }

    /// Using bind/unbind to handle managing data rather than doing it directly in `init` allows us
    /// to make sure that we're not loading data or affecting state while the view isn't visible.
    override func bindViewModel() {
        super.bindViewModel()

        fetchPosts()
    }

    func showPostDetail(_ postId: Int) {
        coordinator.handleRoute(.post(postId))
    }

    func favourite(_ postId: Int) {
        guard let postIndex = allPosts.firstIndex(where: { $0.id == postId }) else {
            return
        }

        allPosts[postIndex].favourite.toggle()
    }

    private func fetchPosts() {
        contentLoadState = .loading

        // This view model fetches a list of posts, then a list of users that made those posts,
        // then combines the text and user names into a ViewState for display.
        Task { @MainActor in
            do {
                struct Raw {
                    var posts: [Post]
                    var users: [User]
                }

                // Wait a little here so we can show our nice loading view
                sleep(1)

                async let rawPosts = try postRepo.getPostList(cacheMode: .cacheAndUpdate)
                async let users = try userRepo.getUsers(cacheMode: .cacheAndUpdate)

                let raw = try Raw(posts: await rawPosts, users: await users)
                self.allPosts = raw.posts.compactMap { post in
                    guard let user = raw.users.first(where: { $0.id == post.userId }) else { return nil }

                    return PostViewState(id: post.id, text: post.title, user: user.name )
                }

                contentLoadState = self.allPosts.isEmpty ? .noData : .hasData
            } catch {
                errorService.error.send(error)
            }
        }
    }
}
