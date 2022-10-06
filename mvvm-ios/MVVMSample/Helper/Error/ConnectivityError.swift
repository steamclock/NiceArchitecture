//
//  ConnectivityError.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Foundation
import SteamcLog

public struct ConnectivityError: LoggableError, DisplayableError {
    var typeDescription: StaticString {
        "Network Connectivity Error"
    }

    var title: String {
        typeDescription.description
    }

    var errorDescription: String {
        "Please check your internet connection and try again."
    }

    var message: String {
        errorDescription
    }

    func log() {
        clog.warn("Connectivity Error", self)
    }
}
