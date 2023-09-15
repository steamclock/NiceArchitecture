//
//  PostsCoordinatorView.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import Foundation
import SwiftUI

/// CoordinatorViews act sort of like UINavigationControllers,
/// they are reponsible for abstracting away connections between individual Views and
/// managing transitioning between Views.
/// Doing so reduces the complexity of individual Views, and helps with things like navigation.
struct PostsCoordinatorView: View {
    @ObservedObject var coordinator: PostsCoordinator

    var body: some View {
        NavigationView {
            PostsView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.postDetailViewModel) { viewModel in
                    PostDetailView(viewModel: viewModel)
                }
        }
    }
}
