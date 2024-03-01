//
//  InjectedValues.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import NiceArchitecture

extension InjectedValues {

    // REPOSITORIES

    var postRepository: PostRepositoryProtocol {
        get { Self[PostRepositoryKey.self] }
        set { Self[PostRepositoryKey.self] = newValue }
    }

    var userRepository: UserRepositoryProtocol {
        get { Self[UserRepositoryKey.self] }
        set { Self[UserRepositoryKey.self] = newValue }
    }

    // SERVICES

    var errorService: ErrorService {
        get { Self[ErrorServiceKey.self] }
        set { Self[ErrorServiceKey.self] = newValue }
    }

    var postService: PostServiceProtocol {
        get { Self[PostServiceKey.self] }
        set { Self[PostServiceKey.self] = newValue }
    }

    var userService: UserServiceProtocol {
        get { Self[UserServiceKey.self] }
        set { Self[UserServiceKey.self] = newValue }
    }
}
