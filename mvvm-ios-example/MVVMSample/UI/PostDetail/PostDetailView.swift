//
//  PostDetailView.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import SteamclUtilityBelt
import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel: PostDetailViewModel

    var body: some View {
        StatefulView(
            state: viewModel.contentLoadState,
            hasDataView: {
                if let post = viewModel.post {
                    postView(post)
                } else {
                    noDataView
                }
            }, errorView: { error in
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
            }, noDataView: {
                noDataView
            }
        ).bindToVM(viewModel)
    }

    private func postView(_ post: Post) -> some View {
        VStack {
            Text(post.title)
                .fontWeight(.semibold)

            Text(post.body)
        }.padding()
    }

    private var noDataView: some View {
        Text("No Post 😓")
    }
}
