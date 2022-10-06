//
//  ObservableViewModel.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Combine
import Foundation
import NiceComponents
import SwiftUI

enum AlertType {
    case error
    case confirmation
    case custom(String)
}

class ObservableViewModel: ObservableObject {
    @Injected(\.errorService) var errorService: ErrorService

    var cancellables: [AnyCancellable] = []
    var alertType: AlertType = .confirmation

    @Published var contentLoadState: ContentLoadState = .noData

    private(set) var baseBindCalled = false
    private(set) var baseUnbindCalled = false

    func unbindViewModel() {
        cancellables.cancelAll()

        baseUnbindCalled = true
    }

    func bindViewModel() {
        cancellables.cancelAll()

        bindDisplayableError()

        // We want to make sure that if you override bindViewModel,
        //   you don't forget to call super.bindViewModel(), so set a flag here
        baseBindCalled = true
    }

    // While we want to make sure that be default, view models receive error signals,
    //   different view models may want to handle, or suppress, certain errors.
    private final func bindDisplayableError() {
        errorService.didReceiveDisplayableError
            .receive(on: RunLoop.main)
            .sink { [weak self] displayError in
                self?.handleDisplayableError(displayError)
            }.store(in: &cancellables)
    }

    private func handleDisplayableError(_ error: DisplayableError) {
        contentLoadState = .error(error: error)
    }

    func triggerError() {
        errorService.error.send(UnknownError(message: "You triggered an error!"))
    }
}
