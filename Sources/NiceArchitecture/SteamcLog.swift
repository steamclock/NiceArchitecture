//
//  SteamcLog.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import SteamcLog

// You'll likely want to re-implement SteamcLog with your own Sentry config
private let config = Config(logLevel: .release)
public var clog = SteamcLog(config, sentryConfig: nil)
