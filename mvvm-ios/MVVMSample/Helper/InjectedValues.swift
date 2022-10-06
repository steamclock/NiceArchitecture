//
//  InjectedValues.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation

// https://www.avanderlee.com/swift/dependency-injection/
struct InjectedValues {
    private static var current = InjectedValues()

    static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

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
