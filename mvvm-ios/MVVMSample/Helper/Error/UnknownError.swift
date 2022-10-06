//
//  UnknownError.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Foundation
import SteamcLog

public struct UnknownError: LoggableError, DisplayableError {
    var title: String {
        typeDescription.description
    }

    var typeDescription: StaticString {
        "Unknown Error"
    }

    var errorDescription: String {
        message
    }

    let message: String

    func log() {
        clog.warn("\(typeDescription): \(errorDescription)")
    }
}

