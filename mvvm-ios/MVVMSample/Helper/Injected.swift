//
//  Injected.swift
//  MVVMSample
//
//  Created by Brendan on 2022-08-31.
//

import Foundation

// https://www.avanderlee.com/swift/dependency-injection/
@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
