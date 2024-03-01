//
//  View+BindToViewModel.swift
//  NiceArchitecture: <https://github.com/steamclock/NiceArchitecture>](https://github.com/steamclock/NiceArchitecture)
//
//  Copyright © 2024, Steamclock Software.
//  Some rights reserved: <https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE>](https://github.com/steamclock/NiceArchitecture/blob/main/LICENSE)
//

import NiceComponents
import SwiftUI

public struct BindToVM: ViewModifier {
    @ObservedObject private var viewModel: ObservableVM

    init(_ viewModel: ObservableVM) {
        self.viewModel = viewModel
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                viewModel.bindViewModel()

                if !viewModel.baseBindCalled {
                    fatalError("Observable view model base bindViewModel was not called, you probably forgot to call super.bindViewModel() in your overridden bindViewModel function")
                }
            }
            .onDisappear {
                print("on disappear")
                viewModel.unbindViewModel()

                if !viewModel.baseUnbindCalled {
                    fatalError("Observable view model base unbindViewModel was not called, you probably forgot to call super.unbindViewModel() in your overridden unbindViewModel function")
                }
            }
    }
}

public extension View {
    func bindToVM(_ viewModel: ObservableVM) -> some View {
        modifier(BindToVM(viewModel))
    }
}
