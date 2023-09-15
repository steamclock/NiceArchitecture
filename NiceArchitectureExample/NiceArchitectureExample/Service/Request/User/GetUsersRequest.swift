//
//  GetUsersRequest.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
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
