//
//  UsersRepository.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Combine
import Foundation
import NiceArchitecture

/// Defining an InjectionKey and injecting a currentValue allows us to swap the repository
/// out for a mocked version while testing. See NiceArchitectureTests for more info.
struct UserRepositoryKey: InjectionKey {
    static var currentValue: UserRepositoryProtocol = UserRepository(cache: CacheService())
}

/// Creating a protocol to accompany your repositories is important for testing
/// to ensure that your mocked repositories keep the same behaviour as the real ones.
protocol UserRepositoryProtocol {
    /// We provide a PassthroughSubject for ViewModels to observe changes in our data
    /// in addition to returning the result directly from the `get` calls to provide
    /// flexibility in how updates are consumed.
    var currentUser: PassthroughSubject<User?, Never> { get set }
    var userList: PassthroughSubject<[User], Never> { get set }

    @discardableResult func getUser(id: String, cacheMode: CacheMode) async throws -> User
    @discardableResult func getUsers(cacheMode: CacheMode) async throws -> [User]

    func logout()
}

/// Repositories serve as bridges between ViewModels and Services.
/// They are responsible for collecting data from Services, cacheing that information when needed,
/// and passing the ViewState back into the ViewModels.
/// They are also responsible for communicating changes in data and state between ViewModels
/// by publishing changes to the data as it happens.
class UserRepository: UserRepositoryProtocol {
    @Injected(\.userService) private var userService: UserServiceProtocol

    private enum CacheKeys {
        static let currentUser = CacheKey<User>(key: "User")
        static let userList = CacheKey<[User]>(key: "UserList")
    }

    private let cache: CacheService

    var currentUser = PassthroughSubject<User?, Never>()
    var userList = PassthroughSubject<[User], Never>()

    init(cache: CacheService) {
        self.cache = cache
    }

    /// Although they are less interesting, a repository might also have some values that
    /// are known to not be async (say cached in user defaults),
    /// which could be simple properties of some kind (ideally, but not necessarily also published)
    #if false
    @Published var loggedInUser: User
    #endif
    // or
    #if false
    var loggedInUser: User {
        get {
            //return Defaults[.currentUser]
        }
        set {
            //Defaults[.currentUser] = newValue
        }
    }
    #endif

    @discardableResult func getUser(id: String, cacheMode: CacheMode) async throws -> User {
        let key = CacheKeys.currentUser
        if let cached = await cache.retrieve(key: key, cacheMode: cacheMode) {
            self.currentUser.send(cached.result)
            if cached.shouldExit { return cached.result }
        }

        let user = try await userService.getUser(id: id)
        await cache.update(key: key, value: user)
        self.currentUser.send(user)
        return user
    }

    @discardableResult func getUsers(cacheMode: CacheMode) async throws -> [User] {
        let key = CacheKeys.userList
        if let cached = await cache.retrieve(key: key, cacheMode: cacheMode) {
            self.userList.send(cached.result)
            if cached.shouldExit { return cached.result }
        }

        let users = try await userService.getUsers()
        await cache.update(key: key, value: users)
        self.userList.send(users)
        return users
    }

    func logout() {
        // TODO
    }
}
