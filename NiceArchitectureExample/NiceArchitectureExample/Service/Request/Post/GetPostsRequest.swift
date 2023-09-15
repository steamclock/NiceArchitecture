//
//  GetPostsRequest.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation
import Netable

/// Fetch a list of all posts from the placeholder API
struct GetPostsRequest: Request {
    typealias Parameters = Empty
    typealias RawResource = [Post]

    public var method = HTTPMethod.get
    public var path = "posts"
}
