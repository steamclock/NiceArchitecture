//
//  InjectionKey.swift
//  MVVMSample
//
//  Created by Brendan on 2022-04-12.
//

// https://www.avanderlee.com/swift/dependency-injection/
public protocol InjectionKey {
    associatedtype Value

    static var currentValue: Self.Value { get set }
}
