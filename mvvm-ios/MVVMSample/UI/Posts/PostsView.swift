//
//  ContentView.swift
//  MVVMSample
//
//  Created by Nigel Brooke on 2021-04-29.
//

import NiceComponents
import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        StatefulView(
            state: viewModel.contentLoadState,
            hasDataView: { postsView },
            errorView: { error in
                VStack {
                    if let error = error as? DisplayableError {
                        Text(error.title)
                        Text(error.message)
                    } else {
                        Text(error.localizedDescription)
                    }

                    Button("Reset") {
                        viewModel.contentLoadState = .hasData
                    }
                }
            }, loadingView: {
                ProgressView()
            }, noDataView: {
                Text("No Posts 😓")
            }
        ).bindToVM(viewModel)
    }
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
    }

    private var postsView: some View {
        List {
            ForEach(viewModel.posts, id: \.id) { post in
                PostCell(post: post)
                    .onTapGesture {
                        viewModel.showPostDetail(post.id)
                    }
            }.onDelete { _ in viewModel.triggerError() }
        }
    }
}
