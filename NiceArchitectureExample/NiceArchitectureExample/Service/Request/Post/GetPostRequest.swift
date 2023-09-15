//
//  GetPostRequest.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation
import Netable

/// Fetch a single post from the placeholder API
struct GetPostRequest: Request {
    typealias Parameters = [String: Int]
    typealias RawResource = Post

    public var method = HTTPMethod.get
    public var path = "post"

    public var postId: Int

    var parameters: [String : Int] {
        ["postId": postId]
    }
}
