//
//  CacheResult.swift
//  MVVMSample
//
//  Created by Jake Miner on 2021-05-25.
//

import Foundation

struct CacheResult<T: Decodable> {
    let result: T
    let shouldExit: Bool
}
