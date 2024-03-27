//
//  EmptyPostCell.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
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
