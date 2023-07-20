//
//  CacheResult.swift
//  NiceUtilities
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Foundation

public struct CacheResult<T: Decodable> {
    public let result: T
    public let shouldExit: Bool
}
