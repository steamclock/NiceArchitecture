//
//  SuppressibleError.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation

/// An error that may not be logged or shown to the user
public protocol SuppressibleError: Error {
    var shouldDisplay: Bool { get }
}
