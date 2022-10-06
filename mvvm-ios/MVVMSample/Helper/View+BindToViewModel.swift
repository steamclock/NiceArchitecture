//
//  View+BindToViewModel.swift
//  MVVMSample
//
//  Created by Brendan on 2022-09-02.
//

import NiceComponents
import SwiftUI

struct BindToVM: ViewModifier {
    @ObservedObject private var viewModel: ObservableViewModel

    init(_ viewModel: ObservableViewModel) {
        self.viewModel = viewModel
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                viewModel.bindViewModel()

                if !viewModel.baseBindCalled {
                    fatalError("Observable view model base bindViewModel was not called, you probably forgot to call super.bindViewModel() in your overridden bindViewModel function")
                }
            }
            .onDisappear {
                viewModel.unbindViewModel()

                if !viewModel.baseUnbindCalled {
                    fatalError("Observable view model base unbindViewModel was not called, you probably forgot to call super.unbindViewModel() in your overridden unbindViewModel function")
                }
            }
    }
}

extension View {
    func bindToVM(_ viewModel: ObservableViewModel) -> some View {
        modifier(BindToVM(viewModel))
    }
}
