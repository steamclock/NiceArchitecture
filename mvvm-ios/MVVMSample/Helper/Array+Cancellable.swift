//
//  Array+Cancellable.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Combine
import Foundation

extension Array where Element: Cancellable {
    mutating func cancelAll() {
        self.forEach { $0.cancel() }
        self.removeAll()
    }
}
