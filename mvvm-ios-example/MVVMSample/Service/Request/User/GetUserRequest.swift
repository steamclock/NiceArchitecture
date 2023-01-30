//
//  GetUserRequest.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-01.
//

import Foundation
import Netable

// Fetch a list of all users from the placeholder API
struct GetUserRequest: UserRequest {
    typealias Parameters = [String: String]
    typealias RawResource = User

    public var method = HTTPMethod.get
    public var path = "user"

    public let userId: String

    public var parameters: [String: String] {
        ["id": userId]
    }
}
