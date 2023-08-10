//
//  UsersRepository.swift
//  MVVMSample
//
//  Created by Jake Miner on 2021-05-25.
//

import Combine
import Foundation
import NiceArchitecture

struct UserRepositoryKey: InjectionKey {
    static var currentValue: UserRepositoryProtocol = UserRepository(cache: CacheService())
}

protocol UserRepositoryProtocol {
    var currentUser: PassthroughSubject<User?, Never> { get set }
    var userList: PassthroughSubject<[User], Never> { get set }

    @discardableResult func getUser(id: String, cacheMode: CacheMode) async throws -> User
    @discardableResult func getUsers(cacheMode: CacheMode) async throws -> [User]

    func logout()
}

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

    // Although they are less interesting, a repository might also have some values that are known to not be async (say cached in user defaults), which could be simple properties of some kind
    // (ideally, but not necessarily also published)
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
