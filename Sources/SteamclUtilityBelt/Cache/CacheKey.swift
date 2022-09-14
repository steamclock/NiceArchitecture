//
//  CacheKey.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
//

import Foundation

public struct CacheKey<T: Codable> {
    let key: Int

    public init<T: Hashable>(key: T) {
        self.key = key.hashValue
    }
}
