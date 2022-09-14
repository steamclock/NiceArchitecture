//
//  SuppressibleError.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
//

import Foundation

/// An error that may not be logged or shown to the user
public protocol SuppressibleError: Error {
    var shouldDisplay: Bool { get }
}
