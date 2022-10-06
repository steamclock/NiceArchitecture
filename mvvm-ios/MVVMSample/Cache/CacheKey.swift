//
//  CacheKey.swift
//  MVVMSample
//
//  Created by Jake Miner on 2021-05-27.
//

import Foundation

struct CacheKey<T: Codable> {
    let key: Int

    init<T: Hashable>(key: T) {
        self.key = key.hashValue
    }
}
