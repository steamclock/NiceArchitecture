//
//  SteamcLog.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-14.
//

import Foundation
import SteamcLog

// You'll likely want to re-implement SteamcLog with your own Sentry config
private let config = Config(logLevel: .release)
public var clog = SteamcLog(config, sentryConfig: nil)
