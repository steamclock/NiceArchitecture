//
//  PostCell.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation
import SwiftUI

struct PostCell: View {
    let post: PostViewState
    let onFavourite: (Int) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(post.user)
                    .fontWeight(.semibold)

                Text(post.text)
            }

            Spacer()

            Button(
                action: {
                    onFavourite(post.id)
                }, label: {
                    if post.favourite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(.gray)
                    }
                }
            )
        }
        .padding(8)
        .frame(minHeight: 64)
        .background(Color(hex: "F2F2F7"))
        .cornerRadius(8)
    }
}
