//
//  LoggableError.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
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
