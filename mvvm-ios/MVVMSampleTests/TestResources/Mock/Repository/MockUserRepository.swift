//
//  MockUserRepository.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2022-09-09.
//

import Combine
import Foundation
import SteamclUtilityBelt
@testable import MVVMSample

class MockUserRepository: UserRepositoryProtocol {
    var currentUser = PassthroughSubject<User?, Never>()

    var userList = PassthroughSubject<[User], Never>()

    private var users: [User]

    init(users: [User]) {
        self.users = users
    }

    func getUser(id: String, cacheMode: CacheMode) async throws -> User {
        users.first!
    }

    func getUsers(cacheMode: CacheMode) async throws -> [User] {
        users
    }

    func logout() {}
}
