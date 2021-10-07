//
//  ErrorViewModifier.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 07.10.2021.
//

import SwiftUI

struct ErrorViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    var errorView: ErrorView
    func body(content: Content) -> some View {
        VStack {
            if isPresented {
                errorView
            }
            content
        }
    }
}

extension View {
    func errorView(isPresented: Binding<Bool>, content: () -> ErrorView) -> some View {
        self.modifier(ErrorViewModifier(isPresented: isPresented, errorView: content()))
    }
}
