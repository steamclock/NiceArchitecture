//
//  Array+Cancellable.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Combine
import Foundation

public extension Array where Element: Cancellable {
    mutating func cancelAll() {
        self.forEach { $0.cancel() }
        self.removeAll()
    }
}
