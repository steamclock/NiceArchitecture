//
//  ConnectivityError.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

public struct ConnectivityError: LoggableError, DisplayableError {
    public var typeDescription: StaticString {
        "Network Connectivity Error"
    }

    public var title: String {
        typeDescription.description
    }

    public var errorDescription: String {
        "Please check your internet connection and try again."
    }

    public var message: String {
        errorDescription
    }

    public func log() {
        clog.warn("Connectivity Error", self)
    }

    public init() {}
}

