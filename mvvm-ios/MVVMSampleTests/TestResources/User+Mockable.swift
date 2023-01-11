//
//  User+Mockable.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2023-01-10.
//

import FactoryBird
import Foundation
@testable import MVVMSample

extension User: Mockable {
    public static var mocked: User {
        User(
            id: Mocked.int(),
            name: Mocked.fullName)
    }
}


