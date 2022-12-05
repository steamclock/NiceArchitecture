//
//  DisplayableError.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
//

import Foundation

/// An error that will be presented to the user, either via Alert, in-line or otherwise.
public protocol DisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
