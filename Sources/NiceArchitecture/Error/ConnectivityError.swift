//
//  ConnectivityError.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

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

