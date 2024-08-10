//
//  PostsCoordinatorView.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import SwiftUI

/// CoordinatorViews act sort of like UINavigationControllers,
/// they are reponsible for abstracting away connections between individual Views and
/// managing transitioning between Views.
/// Doing so reduces the complexity of individual Views, and helps with things like navigation.
struct PostsCoordinatorView: View {
    @Bindable var coordinator: PostsCoordinator

    var body: some View {
        NavigationStack {
            PostsView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.postDetailViewModel) { viewModel in
                    PostDetailView(viewModel: viewModel)
                }
        }
    }
}
