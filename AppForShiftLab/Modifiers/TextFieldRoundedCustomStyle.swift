//
//  TextFieldRoundedCustomStyle.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import SwiftUI

struct TextFieldRoundedCustomStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
    }
}
