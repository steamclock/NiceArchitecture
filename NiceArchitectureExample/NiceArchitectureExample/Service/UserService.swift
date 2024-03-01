//
//  UserService.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import Netable
import NiceArchitecture

/// Defining an InjectionKey and injecting a currentValue allows us to swap the repository
/// out for a mocked version while testing. See NiceArchitectureTests for more info.
struct UserServiceKey: InjectionKey {
    static var currentValue: UserServiceProtocol = UserService()
}

/// Creating a protocol to accompany your services is important for testing
/// to ensure that your mocked repositories keep the same behaviour as the real ones.
protocol UserServiceProtocol {
    func getUser(id: String) async throws -> User
    func getUsers() async throws -> [User]
}

/// Services are responsible for communicating with external resources.
/// Services should always have minimal internal state - maybe an initial configuration,
/// maybe some ephemeral state like active requests for a network service at most.
/// If it is something that stores a lot of state, it should be in a repository.
/// Our services tend to be fairly lightweight, as most work is done by `Netable`'s `Requests`,
/// including decoding and transforming data provided by the APIs.
/// Using a service here instead of referencing Netable directly from the Repositories
/// gives us an opportunity to compose requests, handle errors, and keep the Repository code
/// a little easier to read, though for some smaller projects may not be strictly necessary.
class UserService: UserServiceProtocol {
    private let netable = Netable(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)

    func getUser(id: String) async throws -> User {
        try await netable.request(GetUserRequest(userId: id))
    }

    func getUsers() async throws -> [User] {
        try await netable.request(GetUsersRequest())
    }
}
