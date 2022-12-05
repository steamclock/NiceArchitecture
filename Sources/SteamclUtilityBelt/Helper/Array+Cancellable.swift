//
//  Array+Cancellable.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
//

import Combine
import Foundation

public extension Array where Element: Cancellable {
    mutating func cancelAll() {
        self.forEach { $0.cancel() }
        self.removeAll()
    }
}
