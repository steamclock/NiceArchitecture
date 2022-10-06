//
//  PostCell.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-09.
//

import Foundation
import SwiftUI

struct PostCell: View {
    let post: PostViewState

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.user)
                .fontWeight(.semibold)
            Text(post.text)
        }
    }
}
