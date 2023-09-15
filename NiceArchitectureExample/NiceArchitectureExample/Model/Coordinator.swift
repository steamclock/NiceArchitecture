//
//  Coordinator.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get }
}

/// While sometimes helpful, a Coordinator doesn't need to have a `parentCoordinator` defined,
/// So we set it to `nil` to reduce repetition.
extension Coordinator {
    var parentCoordinator: Coordinator? {
        nil
    }
}
