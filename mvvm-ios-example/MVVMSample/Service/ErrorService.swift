//
//  ErrorService.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import Combine
import Foundation
import NiceUtilities

struct ErrorServiceKey: InjectionKey {
    static var currentValue = ErrorService()
}

class ErrorService {
    private var cancellables = [AnyCancellable]()

    private let incomingError = PassthroughSubject<Error, Never>()
    let didReceiveDisplayableError = PassthroughSubject<DisplayableError, Never>()

    init() {
        incomingError
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }

                if let suppressibleError = error as? SuppressibleError {
                    clog.debug("Suppressed error: \(suppressibleError.localizedDescription)")
                    return
                }

                if let loggableError = error as? LoggableError {
                    loggableError.log()
                } else {
                    self.logUnhandled(error: error)
                }

                guard let displayError = error as? DisplayableError else {
                    self.didReceiveDisplayableError.send(UnknownError(message: error.localizedDescription))
                    clog.info("Showing unknown error: \(error)")
                    return
                }

                self.didReceiveDisplayableError.send(displayError)
            }.store(in: &cancellables)
    }

    func capture(_ error: Error) {
        if let loggableError = error as? LoggableError, loggableError.isConnectionError {
            incomingError.send(ConnectivityError())
            return
        }

        incomingError.send(error)
    }

    private func logUnhandled(error: Error) {
        switch error {
        case let decodingError as DecodingError:
            clog.error("Decoding error", info: decodingError.errorDescription)
        default:
            clog.info("An unknown or unhandled error occurred: \(error.localizedDescription)")
        }
    }
}
