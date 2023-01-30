//
//  Models.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import Foundation

// Network model object. Note: API has more fields than this, this is just the subset we need

// A text post made by a particular user
struct Post: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

