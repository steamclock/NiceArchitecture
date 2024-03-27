//
//  PostDetailViewModel.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Combine
import Foundation
import NiceArchitecture

class PostDetailViewModel: ObservableVM {
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
    }

    private func fetchPostDetails() {
        contentLoadState = .loading

        Task { @MainActor in
            do {
                sleep(1)
                
                self.post = try await postRepo.getPost(id: postId, cacheMode: .cacheOnly)
            } catch {
                errorService.error.send(error)
            }
        }
    }
}
