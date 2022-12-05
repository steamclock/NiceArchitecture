//
//  LoadingView.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-14.
//

import NiceComponents
import SwiftUI
import UIKit

public struct LoadingView<Footer: View>: View {
    let style: UIActivityIndicatorView.Style
    let footer: () -> Footer

    public init(_ style: UIActivityIndicatorView.Style = .large, footer: @escaping () -> Footer) {
        self.style = style
        self.footer = footer
    }

    public var body: some View {
        VStack(alignment: .center) {
            ActivityIndicator(isAnimating: true) { $0.style = style }

            footer()
        }
    }
}

public extension LoadingView where Footer == EmptyView {
    init(_ style: UIActivityIndicatorView.Style = .large) {
        self.init(style, footer: { EmptyView() })
    }
}

