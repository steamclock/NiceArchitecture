//
//  UnknownError.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

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

