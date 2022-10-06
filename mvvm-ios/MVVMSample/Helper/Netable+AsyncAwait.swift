//
//  Netable+AsyncAwait.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Netable

// In the future Netable will support async/await directly. Until then we need to help it out a little...
extension Netable {
    @discardableResult public func request<T: Request>(_ request: T) async throws -> T.FinalResource {
        try await withCheckedThrowingContinuation { continuation in
            self.request(request) { response in
                switch response {
                case .success(let result):
                    continuation.resume(returning: result)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
