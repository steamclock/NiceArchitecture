//
//  PostsCoordinatorView.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import Foundation
import SwiftUI

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
