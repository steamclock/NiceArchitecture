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

