//
//  NiceArchitectureExample.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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
