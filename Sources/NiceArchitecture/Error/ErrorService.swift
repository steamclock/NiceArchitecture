//
//  ErrorService.swift
//  NiceArchitecture
//
//  Created by Brendan on 2022-09-13.
//  Copyright © 2023 Steamclock Software. All rights reserved.

import Combine
import Foundation

public struct ErrorServiceKey: InjectionKey {
    public static var currentValue = ErrorService()
}

public extension InjectedValues {
    var errorService: ErrorService {
        get { Self[ErrorServiceKey.self] }
        set { Self[ErrorServiceKey.self] = newValue }
    }
}

public class ErrorService {
    private var cancellables = [AnyCancellable]()

    public var error = PassthroughSubject<Error, Never>()
    public var didReceiveDisplayableError = PassthroughSubject<DisplayableError, Never>()

    public init() {
        error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }

                if let suppressibleError = error as? SuppressibleError {
                    clog.debug("Suppressed error: \(suppressibleError.localizedDescription)")
                    return
                }

                if let loggableError = error as? LoggableError {
                    if loggableError.isConnectionError {
                        self.didReceiveDisplayableError.send(ConnectivityError())
                        return
                    }
                    loggableError.log()
                }

                if let displayError = error as? DisplayableError {
                    self.didReceiveDisplayableError.send(displayError)
                    return
                }

                switch error {
                case let decodingError as DecodingError:
                    clog.error("Decoding error", info: decodingError.errorDescription)
                default:
                    clog.info("An unknown or unhandled error occurred: \(error.localizedDescription)")
                }

                let displayableError = UnknownError(message: "Please try again later.")
                self.didReceiveDisplayableError.send(displayableError)
                clog.info("Showing displayable error: \(displayableError)")
            }.store(in: &cancellables)
    }
}

