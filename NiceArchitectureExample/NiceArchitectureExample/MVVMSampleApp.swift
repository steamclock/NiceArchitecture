//
//  MVVMSampleApp.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import SteamcLog
import SwiftUI

private let config = Config(logLevel: .release)
let clog = SteamcLog(config, sentryConfig: nil)

@main
struct MVVMSampleApp: App {
    var body: some Scene {
        WindowGroup {
            PostsCoordinatorView(coordinator: PostsCoordinator())
        }
    }
}
