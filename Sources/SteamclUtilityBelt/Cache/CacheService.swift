//
//  CacheService.swift
//  SteamclUtilityBelt
//
//  Created by Jake Miner on 2021-05-25.
//

import Foundation

public actor CacheService {
    private var cachedObjects = [Int: Codable]()
    private var cachedRequests = [Int: [Int]]()

    public init() {}

    public func clearCache() async {
        cachedObjects.removeAll()
        cachedRequests.removeAll()
    }

    public func remove<T: Codable>(key: CacheKey<T>) async {
        cachedObjects[key.key] = nil
    }

    public func removeRequest<T: Codable & Identifiable>(key: CacheKey<[T]>) async {
        if let cached = cachedRequests[key.key] {
            cached.forEach { cachedRequests[$0] = nil }
        }

        cachedRequests[key.key] = nil
    }

    public func retrieve<T: Codable>(key: CacheKey<T>, cacheMode: CacheMode) async -> CacheResult<T>? {
        if cacheMode == .noCache { return nil }

        if let cached = cachedObjects[key.key] as? T {
            return CacheResult(result: cached, shouldExit: cacheMode == .cacheOnly)
        }

        return nil
    }

    public func retrieveRequest<T: Codable & Identifiable>(key: CacheKey<[T]>, cacheMode: CacheMode) async -> CacheResult<[T]>? {
        if cacheMode == .noCache { return nil }

        if let request = cachedRequests[key.key] {
            let objects = request.compactMap { cachedObjects[$0] as? T }
            return CacheResult(result: objects, shouldExit: cacheMode == .cacheOnly)
        }

        return nil
    }

    public func update<T: Codable>(key: CacheKey<T>, value: T) async {
        self.cachedObjects[key.key] = value
    }

    public func updateRequest<T: Codable & Identifiable>(key: CacheKey<[T]>, values: [T]) async {
        values.forEach { value in
            self.cachedObjects[value.id.hashValue] = value
        }
        self.cachedRequests[key.key] = values.map { $0.id.hashValue }
    }
}
