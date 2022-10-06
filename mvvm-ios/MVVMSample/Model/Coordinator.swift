//
//  Coordinator.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get }
}

extension Coordinator {
    var parentCoordinator: Coordinator? {
        nil
    }
}
