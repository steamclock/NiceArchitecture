//
//  GetPostRequest.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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
