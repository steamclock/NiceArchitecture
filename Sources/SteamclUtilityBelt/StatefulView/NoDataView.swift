//
//  NoDataView.swift
//  SteamclUtilityBelt
//
//  Created by Brendan on 2022-09-14.
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
