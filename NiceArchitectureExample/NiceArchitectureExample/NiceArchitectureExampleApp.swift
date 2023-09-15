//
//  NiceArchitectureExample.swift
//  NiceArchitecture
//
//  Created by Nigel Brooke on 2021-04-29.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import SteamcLog
import SwiftUI

private let config = Config(logLevel: .release)
let clog = SteamcLog(config, sentryConfig: nil)

@main
struct NiceArchitectureExample: App {
    var body: some Scene {
        WindowGroup {
            PostsCoordinatorView(coordinator: PostsCoordinator())
        }
    }
}
