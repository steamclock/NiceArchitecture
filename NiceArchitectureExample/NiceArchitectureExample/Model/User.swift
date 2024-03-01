//
//  User.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

/// A user object.
/// This model represents the object as returned by the network.
/// Note that the API has more fields than this, but we only retain the subset we need.
struct User: Codable {
    var id: Int
    var name: String
}
