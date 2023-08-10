//
//  CacheKey.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation

public struct CacheKey<T: Codable> {
    let key: Int

    public init<T: Hashable>(key: T) {
        self.key = key.hashValue
    }
}
