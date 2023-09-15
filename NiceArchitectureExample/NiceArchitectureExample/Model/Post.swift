//
//  Post.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation

/// A text post made by a particular user.
/// This model represents the object as returned by the network.
/// Note that the API has more fields than this, but we only retain the subset we need.
struct Post: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

