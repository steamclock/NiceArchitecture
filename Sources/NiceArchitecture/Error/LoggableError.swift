//
//  LoggableError.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

// An error that will be passed into SteamcLog and logged.
public protocol LoggableError: Error {
    var typeDescription: StaticString { get }
    var errorDescription: String { get }

    func log()
}

public extension LoggableError {
    var isConnectionError: Bool {
        let nsError = self as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet
    }
}
