//
//  Injected.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-13.
//

import Foundation

// https://www.avanderlee.com/swift/dependency-injection/
@propertyWrapper
public struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    public var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }

    public init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

public struct InjectedValues {
    private static var current = InjectedValues()

    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    public static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

public protocol InjectionKey {
    associatedtype Value

    static var currentValue: Self.Value { get set }
}

