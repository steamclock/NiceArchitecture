//
//  UserService.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation
import Netable

struct UserServiceKey: InjectionKey {
    static var currentValue: UserServiceProtocol = UserService()
}

protocol UserServiceProtocol {
    func getUser(id: String) async throws -> User
    func getUsers() async throws -> [User]
}

class UserService: UserServiceProtocol {
    private let netable = Netable(baseURL: URL(string: "https://jsonplaceholder.typicode.com/")!)

    func getUser(id: String) async throws -> User {
        try await netable.request(GetUserRequest(userId: id))
    }

    func getUsers() async throws -> [User] {
        try await netable.request(GetUsersRequest())
    }

    // TODO: Add some kind of update example, or something that deals with the current user?
}
