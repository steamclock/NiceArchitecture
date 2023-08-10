//
//  LoadingView.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

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

