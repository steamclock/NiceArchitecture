//
//  Array+Cancellable.swift
//  NiceUtilities
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Combine
import Foundation

public extension Array where Element: Cancellable {
    mutating func cancelAll() {
        self.forEach { $0.cancel() }
        self.removeAll()
    }
}
