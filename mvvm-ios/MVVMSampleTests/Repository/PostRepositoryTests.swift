//
//  PostRepositoryTests.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Combine
import Nimble
import Quick
import SteamclUtilityBelt
@testable import MVVMSample

class PostsRepositorySpec: QuickSpec {
    var postRepository: PostRepository!
    var cancellables = Set<AnyCancellable>()

    override func spec() {
        beforeEach {
            InjectedValues[\.postService] = MockPostService()
            self.postRepository = PostRepository(cache: CacheService())
        }

        describe("get posts") {
            it("should passthrough and return single posts") {
                self.postRepository.post
                    .sink { post in
                        expect(post) != nil
                    }.store(in: &self.cancellables)

                let post = try? await self.postRepository.getPost(id: 1, cacheMode: .cacheAndUpdate)

                expect(post) != nil
            }

            it("should passthrough the post list") {
                self.postRepository.postList
                    .sink { posts in
                        expect(posts.count) != 0
                    }.store(in: &self.cancellables)

                let posts = try? await self.postRepository.getPostList(cacheMode: .cacheAndUpdate)

                expect(posts) != nil
            }
        }
    }
}
