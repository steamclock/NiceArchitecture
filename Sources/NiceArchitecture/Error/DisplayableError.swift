//
//  DisplayableError.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation

/// An error that will be presented to the user, either via Alert, in-line or otherwise.
public protocol DisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
