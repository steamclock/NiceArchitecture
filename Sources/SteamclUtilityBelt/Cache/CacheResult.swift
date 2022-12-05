//
//  CacheResult.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-14.
//

import Foundation

public struct CacheResult<T: Decodable> {
    public let result: T
    public let shouldExit: Bool
}
