//
//  GetUsersRequest.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import Netable

/// Fetch a list of all users from the placeholder API
struct GetUsersRequest: Request {
    typealias Parameters = Empty
    typealias RawResource = [User]

    public var method = HTTPMethod.get
    public var path = "users"
}
