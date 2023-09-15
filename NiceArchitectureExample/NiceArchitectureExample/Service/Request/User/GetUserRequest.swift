//
//  GetUserRequest.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
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
