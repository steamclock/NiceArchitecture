//
//  PostsView.swift
//  NiceArchitectureExample
//
//  Created by Nigel Brooke on 2021-04-29.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import NiceArchitecture
import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        ScrollView {
            Picker(
                "Select a post",
                selection: $viewModel.displayState
            ) {
                ForEach(PostsDisplayState.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.pickerStyle(.segmented)

            StatefulView(
                state: viewModel.contentLoadState,
                hasDataView: { postsView },
                errorView: { error in
                    errorView
                }, loadingView: {
                    loadingView
                }
            )
        }.bindToVM(viewModel)
    }
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
    }

    private var errorView: some View {
        VStack {
            Spacer()

            Text("Something's gone wrong! Try reloading.")

            Spacer()
        }
    }

    private var loadingView: some View {
        ForEach(0..<10) { _ in
            EmptyPostCell()
        }
    }

    private var postsView: some View {
        ForEach(viewModel.filteredPosts, id: \.id) { post in
            PostCell(post: post) { id in
                viewModel.favourite(id)
            }.onTapGesture {
                viewModel.showPostDetail(post.id)
            }
        }.onDelete { _ in viewModel.triggerError() }
        .padding(.horizontal, 8)
    }
}
