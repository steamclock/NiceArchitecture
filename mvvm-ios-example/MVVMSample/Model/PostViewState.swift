//
//  ViewStates.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import Foundation

// A view state is any value type that the View reads from the view model to actually configure things
// It could be a simplification or reorganization of some model type. Here the post for display combines the "Post" and "User" object into
// something that can be blasted straight into the list
struct PostViewState: Identifiable {
    var id: Int
    var text: String
    var user: String
}

// A view state might also just be a model-layer type if the mapping between the model and the view is straightforward enough
