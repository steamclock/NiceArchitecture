//
//  Post.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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

