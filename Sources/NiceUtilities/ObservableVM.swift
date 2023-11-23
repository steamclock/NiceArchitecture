//
//  ObservableVM.swift
//  NiceUtilities
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Combine
import Foundation
import NiceComponents
import SwiftUI

open class ObservableVM: ObservableObject {
    @Injected(\.errorService) public var errorService: ErrorService

    public var cancellables: [AnyCancellable] = []

    @Published public var contentLoadState: ContentLoadState = .noData
    @Published public var displayErrorAlert: DisplayableError?

    private(set) var baseBindCalled = false
    private(set) var baseUnbindCalled = false

    public init() {}

    open func unbindViewModel() {
        cancellables.cancelAll()

        baseUnbindCalled = true
    }

    open func bindViewModel() {
        cancellables.cancelAll()

        bindDisplayableError()

        // We want to make sure that if you override bindViewModel,
        //   you don't forget to call super.bindViewModel(), so set a flag here
        baseBindCalled = true
    }

    // While we want to make sure that by default, view models receive error signals,
    //   different view models may want to handle, or suppress, certain errors.
    open func bindDisplayableError() {
        errorService.didReceiveDisplayableError
            .receive(on: RunLoop.main)
            .sink { [weak self] displayError in
                self?.handleDisplayableError(displayError)
            }.store(in: &cancellables)
    }

    open func handleDisplayableError(_ error: DisplayableError) {
        /// Depending on what you'd like to do here, or how you'd like to display your error you have two options:
        /// 1. You can show the error in-line using content load state
        /// 2. You can use displayErrorAlert to show the error as a popup
//        contentLoadState = .error(error: error)
        displayErrorAlert = error
    }

    public func triggerError() {
        errorService.error.send(UnknownError(message: "You triggered an error!"))
    }

    func errorAlert(onDismiss: (() -> Void)? = nil) -> Alert {
        if let error = displayErrorAlert {
            return Alert(
                title: Text(error.title),
                message: Text(error.message),
                dismissButton: .default(Text("Ok")) {
                    onDismiss?()
                    self.displayErrorAlert = nil
                }
            )
        } else {
            return Alert(title: Text("Unhandled Error"))
        }
    }
}
