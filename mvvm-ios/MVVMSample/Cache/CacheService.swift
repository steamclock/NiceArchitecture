//
//  InMemoryCacheService.swift
//  MVVMSample
//
//  Created by Jake Miner on 2021-05-25.
//

import Foundation

struct CacheServiceKey: InjectionKey {
    static var currentValue = CacheService()
}

actor CacheService {
    private var cachedObjects = [Int: Codable]()
    private var cachedRequests = [Int: [Int]]()

    func clearCache() async {
        cachedObjects.removeAll()
        cachedRequests.removeAll()
    }

    func remove<T: Codable>(key: CacheKey<T>) async {
        cachedObjects[key.key] = nil
    }

    func removeRequest<T: Codable & Identifiable>(key: CacheKey<[T]>) async {
        if let cached = cachedRequests[key.key] {
            cached.forEach { cachedRequests[$0] = nil }
        }

        cachedRequests[key.key] = nil
    }

    func retrieve<T: Codable>(key: CacheKey<T>, cacheMode: CacheMode) async -> CacheResult<T>? {
        if cacheMode == .noCache { return nil }

        if let cached = cachedObjects[key.key] as? T {
            return CacheResult(result: cached, shouldExit: cacheMode == .cacheOnly)
        }

        return nil
    }

    func retrieveRequest<T: Codable & Identifiable>(key: CacheKey<[T]>, cacheMode: CacheMode) async -> CacheResult<[T]>? {
        if cacheMode == .noCache { return nil }

        if let request = cachedRequests[key.key] {
            let objects = request.compactMap { cachedObjects[$0] as? T }
            return CacheResult(result: objects, shouldExit: cacheMode == .cacheOnly)
        }

        return nil
    }

    func update<T: Codable>(key: CacheKey<T>, value: T) async {
        self.cachedObjects[key.key] = value
    }

    func updateRequest<T: Codable & Identifiable>(key: CacheKey<[T]>, values: [T]) async {
        values.forEach { value in
            self.cachedObjects[value.id.hashValue] = value
        }
        self.cachedRequests[key.key] = values.map { $0.id.hashValue }
    }
}
