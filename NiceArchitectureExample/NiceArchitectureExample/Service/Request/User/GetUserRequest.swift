//
//  GetUserRequest.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import Netable

/// Fetch a single user from the placeholder API
struct GetUserRequest: Request {
    typealias Parameters = [String: String]
    typealias RawResource = User

    public var method = HTTPMethod.get
    public var path = "user"

    public let userId: String

    public var parameters: [String: String] {
        ["id": userId]
    }
}
