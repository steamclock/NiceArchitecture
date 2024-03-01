//
//  NoDataView.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import NiceComponents
import SwiftUI

public struct NoDataView: View {
    private let message: String

    public init(message: String? = nil) {
        let defaultMessage = "No data."
        self.message = message ?? defaultMessage
    }

    public var body: some View {
        VStack(alignment: .center) {
            BodyText(message)
        }
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
