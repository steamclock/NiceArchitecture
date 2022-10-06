//
//  DisplayableError.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Foundation

protocol DisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
