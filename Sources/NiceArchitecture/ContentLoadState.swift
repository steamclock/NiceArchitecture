//
//  ContentLoadState.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

public enum ContentLoadState: Equatable {
    case loading
    case noData
    case hasData
    case error(error: Error)

    public static func == (lhs: ContentLoadState, rhs: ContentLoadState) -> Bool {
        switch lhs {
        case .loading:
            if case .loading = rhs { return true }
        case .noData:
            if case .noData = rhs { return true }
        case .hasData:
            if case .hasData = rhs { return true }
        case .error(let error):
            if case .error(let rhsError) = rhs {
                return error.localizedDescription == rhsError.localizedDescription
            }
        }
        return false
    }
}
