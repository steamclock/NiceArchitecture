//
//  LoadingView.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import SwiftUI
import UIKit

public struct LoadingView<Footer: View>: View {
    let footer: () -> Footer

    public init(footer: @escaping () -> Footer) {
        self.footer = footer
    }

    public var body: some View {
        VStack(alignment: .center) {
            ProgressView()
        }
    }
}

public extension LoadingView where Footer == EmptyView {
    init() {
        self.init(footer: { EmptyView() })
    }
}

