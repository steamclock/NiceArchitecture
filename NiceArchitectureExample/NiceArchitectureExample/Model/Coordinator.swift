//
//  Coordinator.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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
