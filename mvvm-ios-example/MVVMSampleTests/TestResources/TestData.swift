//
//  TestData.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-15.
//

import Foundation

@propertyWrapper
struct TestData<T: Decodable> {
    private let filename: String
    private class DummyClass {}

    var wrappedValue: T {
        guard let url = Bundle(for: DummyClass.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Could not find file \(filename).json")
        }

        return try! JSONDecoder().decode(T.self, from: Data(contentsOf: url))
    }

    init(_ filename: String) {
        self.filename = filename
    }
}
