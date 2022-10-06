//
//  LoggableError.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Foundation

protocol LoggableError: Error {
    var typeDescription: StaticString { get }
    var errorDescription: String { get }

    func log()
}

extension LoggableError {
    var isConnectionError: Bool {
        let nsError = self as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorNotConnectedToInternet
    }
}
