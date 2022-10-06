//
//  PostDetailViewModel.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import Foundation
import Combine

class PostDetailViewModel: ObservableViewModel {
    @Injected(\.postRepository) private var postRepo: PostRepositoryProtocol

    private unowned let coordinator: PostsCoordinator

    let postId: Int
    @Published var post: Post? {
        didSet {
            contentLoadState = post == nil ? .noData : .hasData
        }
    }

    init(coordinator: PostsCoordinator, postId: Int) {
        self.coordinator = coordinator
        self.postId = postId
    }

    override func bindViewModel() {
        super.bindViewModel()

        fetchPostDetails()

        contentLoadState = .loading
    }

    private func fetchPostDetails() {
        Task { @MainActor in
            do {
                self.post = try await postRepo.getPost(id: postId, cacheMode: .cacheOnly)
            } catch {
                errorService.error.send(error)
            }
        }
    }
}
