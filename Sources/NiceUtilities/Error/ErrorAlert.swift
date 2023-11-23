//
//  ErrorAlert.swift
//  NiceUtilities
//
//  Created by Brendan Lensink on 2023-11-23.
//  Copyright © 2023 Steamclock Software. All rights reserved.


import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var error: DisplayableError?
    let errorAlert: ((() -> Void)?) -> Alert

    @Binding private var isPresented: Bool

    init(_ error: Binding<DisplayableError?>, alert: @escaping ((() -> Void)?) -> Alert) {
        self._error = error
        self.errorAlert = alert

        self._isPresented = Binding(
            get: { error.wrappedValue != nil },
            set: { value in
                if !value {
                    error.wrappedValue = nil
                }
            }
        )
    }

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                errorAlert {}
            }
    }
}

extension View {
    func errorAlert(_ error: Binding<DisplayableError?>, alert: @escaping ((() -> Void)?) -> Alert) -> some View {
        modifier(ErrorAlertModifier(error, alert: alert))
    }
}
