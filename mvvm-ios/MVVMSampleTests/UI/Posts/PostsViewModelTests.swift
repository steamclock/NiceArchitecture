//
//  PostsViewModelTests.swift
//  RidwellTests
//
//  Created by Jennifer Cooper on 2022-04-19.
//

import Combine
import Nimble
import Quick
import SteamclUtilityBelt
@testable import MVVMSample

class PostsViewModelSpec: QuickSpec {
    var viewModel: PostsViewModel!
    var cancellables = Set<AnyCancellable>()

    private var users: [User] = User.mockedArrayOf(10)
    private var posts: [Post] = Post.mockedArrayOf(10)

    override func spec() {
        beforeEach {
            InjectedValues[\.postRepository] = MockPostRepository(posts: self.posts)
            InjectedValues[\.userRepository] = MockUserRepository(users: self.users)

            self.viewModel = PostsViewModel(coordinator: PostsCoordinator())
        }

        describe("contentLoadState") {
            it("starts with the correct load state") {
                expect(self.viewModel.contentLoadState).to(equal(.noData))
            }

            it("updates to loading when fetching data") {
                self.viewModel.bindViewModel()
                expect(self.viewModel.contentLoadState).to(equal(.loading))
            }

            it("updates to hasData after fetching data") {
                self.viewModel.$posts
                   .dropFirst()
                   .sink { vm in
                       expect(self.viewModel.contentLoadState).to(equal(.hasData))
                   }.store(in: &self.cancellables)

                self.viewModel.bindViewModel()
            }
        }

        afterEach {
            self.viewModel = nil
        }
    }
}
