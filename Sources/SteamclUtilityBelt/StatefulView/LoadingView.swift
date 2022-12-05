//
//  LoadingView.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-14.
//

import NiceComponents
import SwiftUI

public struct LoadingView<Footer: View>: View {
    let footer: () -> Footer

    public init(footer: @escaping () -> Footer) {
        self.footer = footer
    }

    public var body: some View {
        VStack(alignment: .center) {
            if #available(macOS 11.0, *) {
                ProgressView()
            } else {
                Text("fix me!")
            }

            footer()
        }
    }
}

public extension LoadingView where Footer == EmptyView {
    init() {
        self.init(footer: { EmptyView() })
    }
}

