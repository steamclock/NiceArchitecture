//
//  DisplayableError.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

/// An error that will be presented to the user, either via Alert, in-line or otherwise.
public protocol DisplayableError: Error {
    var title: String { get }
    var message: String { get }
}
