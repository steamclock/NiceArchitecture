//
//  ErrorView.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import NiceComponents
import SwiftUI

public struct ErrorView: View {
    private let error: Error

    public init(error: Error) {
        self.error = error
    }

    public var body: some View {
        VStack(alignment: .center) {
            if let error = error as? DisplayableError {
                Text(error.title)
                Text(error.message)
            } else {
                BodyText("Error:")
                BodyText(error.localizedDescription)
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: CustomError())
    }
}

private struct CustomError: Error {
    var description: String {
        "Something's gone wrong. Try again later."
    }
}
