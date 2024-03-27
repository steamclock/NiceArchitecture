//
//  ErrorService.swift
//  NiceArchitecture: [https://github.com/steamclock/NiceArchitecture](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software, Ltd.
//  Some rights reserved: [https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Combine
import Foundation
import NiceArchitecture

/// We typically don't find it useful to mock out the error service,
/// so we don't bother with the protocol and just inject the service directly.
struct ErrorServiceKey: InjectionKey {
    static var currentValue = ErrorService()
}

/// Although it's called a Service, the ErrorService is a little different than the other Services
/// since it doesn't actually communicate with the outside world at all.
/// Instead, errors are passing in through the `capture` function from elsewhere
/// and ViewModels listen to `didReceiveDisplayableError` to parse and display errors.
class ErrorService {
    private var cancellables = [AnyCancellable]()

    private let incomingError = PassthroughSubject<Error, Never>()
    var didReceiveDisplayableError = PassthroughSubject<DisplayableError, Never>()

    init() {
        incomingError
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }

                if let loggableError = error as? LoggableError {
                    loggableError.log()
                } else {
                    self.logUnhandled(error: error)
                }

                if let displayError = error as? DisplayableError {
                    self.didReceiveDisplayableError.send(displayError)
                    return
                }

                self.didReceiveDisplayableError.send(UnknownError(message: error.localizedDescription))
                clog.info("Showing unknown error: \(error)")
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
