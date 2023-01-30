//
//  GetPostsRequest.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation
import Netable

// Fetch a list of all posts from the placeholder API
struct GetPostsRequest: PostRequest {
    typealias Parameters = Empty
    typealias RawResource = [Post]

    public var method = HTTPMethod.get
    public var path = "posts"
}
