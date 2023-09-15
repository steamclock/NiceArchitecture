//
//  User.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation

/// A user object.
/// This model represents the object as returned by the network.
/// Note that the API has more fields than this, but we only retain the subset we need.
struct User: Codable {
    var id: Int
    var name: String
}
