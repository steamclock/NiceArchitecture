//
//  Post+Mockable.swift
//  MVVMSampleTests
//
//  Created by Brendan on 2023-01-10.
//

import FactoryBird
import Foundation
@testable import MVVMSample

extension Post: Mockable {
    public static var mocked: MVVMSample.Post {
        Post(
            userId: Mocked.int(),
            id: Mocked.int(),
            title: Mocked.string,
            body: Mocked.string)
    }
}
