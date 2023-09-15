//
//  PostDetailView.swift
//  NiceArchitectureExample
//
//  Created by Brendan on 2022-09-09.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import NiceArchitecture
import SwiftUI

struct PostDetailView: View {
    @ObservedObject var viewModel: PostDetailViewModel

    var body: some View {
        // We provide default views for the other load states,
        // if you're happy with those, you don't need to do anything.
        StatefulView(
            state: viewModel.contentLoadState,
            hasDataView: {
                if let post = viewModel.post {
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.largeTitle)
                            .padding(.bottom, 50)

                        Text(post.body)

                        Spacer()
                    }.padding()
                }
            }
        ).bindToVM(viewModel)
    }
}
