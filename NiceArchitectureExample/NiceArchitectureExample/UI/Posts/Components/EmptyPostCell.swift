//
//  EmptyPostCell.swift
//  NiceArchitectureExample
//
//  Created by Brendan Lensink on 2023-08-14.
//  Copyright © 2023 Steamclock Software. All rights reserved.
//

import SwiftUI

struct EmptyPostCell: View {
    var body: some View {
        HStack {
            Spacer()
        }.frame(minHeight: 64)
        .background(Color(hex: "F2F2F7"))
        .cornerRadius(8)
        .padding(.horizontal, 8)
    }
}

struct EmptyPostCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPostCell()
    }
}
