//
//  UnknownError.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation
import SteamcLog

public struct UnknownError: LoggableError, DisplayableError {
    public var title: String {
        typeDescription.description
    }

    public var typeDescription: StaticString {
        "Unknown Error"
    }

    public var errorDescription: String {
        message
    }

    public let message: String

    public func log() {
        clog.warn("\(typeDescription): \(errorDescription)")
    }

    public init(message: String) {
        self.message = message
    }
}

