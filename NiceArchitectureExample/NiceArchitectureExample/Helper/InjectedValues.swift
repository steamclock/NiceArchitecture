//
//  InjectedValues.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-08-31.
//  Copyright © 2023 Steamclock Software. All rights reserved.
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
