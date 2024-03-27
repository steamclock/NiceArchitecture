//
//  PostDetailView.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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
