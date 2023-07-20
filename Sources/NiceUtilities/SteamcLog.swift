//
//  SteamcLog.swift
//  NiceUtilities
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation
import SteamcLog

// You'll likely want to re-implement SteamcLog with your own Sentry config
private let config = Config(logLevel: .release)
public var clog = SteamcLog(config, sentryConfig: nil)
