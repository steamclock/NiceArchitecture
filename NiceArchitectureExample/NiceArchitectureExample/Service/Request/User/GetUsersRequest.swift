//
//  GetUsersRequest.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation
import Netable

// Fetch a list of all users from the placeholder API
struct GetUsersRequest: UserRequest {
    typealias Parameters = Empty
    typealias RawResource = [User]

    public var method = HTTPMethod.get
    public var path = "users"
}
