//
//  GetPostRequest.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-01.
//

import Foundation
import Netable

// Fetch a list of all posts from the placeholder API
struct GetPostRequest: PostRequest {
    typealias Parameters = [String: Int]
    typealias RawResource = Post

    public var method = HTTPMethod.get
    public var path = "post"

    public var postId: Int

    var parameters: [String : Int] {
        ["postId": postId]
    }
}
