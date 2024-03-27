//
//  PostsCoordinator.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

/// Since this is just a small example project, there isn't much to put here
/// but normally this would contain all of the routes managed by this Coordinator.
enum PostsRoute {
    case post(Int)
}

/// A Coordinator is roughly analagous to UIKit's NavigationController,
/// it should be responsible for holding references to each of the viewModels it manages
/// and use that information, plus any changes in state, to decide which View to present.
/// ViewModels can interact with their coordinator to update the state or navigate to other pages.
class PostsCoordinator: ObservableObject, Coordinator {
    @Published var viewModel: PostsViewModel!
    @Published var postDetailViewModel: PostDetailViewModel?

    init() {
        viewModel = PostsViewModel(coordinator: self)
    }

    func handleRoute(_ route: PostsRoute) {
        switch route {
        case .post(let postId):
            postDetailViewModel = PostDetailViewModel(coordinator: self, postId: postId)
        }
    }
}
