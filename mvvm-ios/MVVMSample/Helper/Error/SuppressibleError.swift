//
//  SuppressibleError.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-08.
//

import Foundation

protocol SuppressibleError: Error {
    var shouldDisplay: Bool { get }
}
