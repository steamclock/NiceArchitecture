//
//  PostsCoordinator.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import Foundation

enum PostsRoute {
    case post(Int)
}

// Although it seems silly for a trivial example like this one,
//    using a coordinator to handle navigation allows us to do things like drill down
//    directly into a sub-page, which is suprisingly difficult with vanilla SwiftUI.
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
