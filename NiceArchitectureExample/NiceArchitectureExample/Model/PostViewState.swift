//
//  ViewStates.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import Foundation

/// A ViewState is a value type read from the ViewModel by a View.
/// It could be a simplification or reorganization of a model type, for example here
/// the PostViewState combines the `Post` and `User` objects into a single type
/// that can be inserted directly into the list.
/// A ViewState may not be necessary if the mapping between model and view is straightforward.
struct PostViewState: Identifiable {
    var id: Int
    var text: String
    var user: String
    var favourite: Bool = false
}
