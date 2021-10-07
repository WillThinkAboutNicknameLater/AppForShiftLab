//
//  PrimaryButtonStyle.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .black
    
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor: fillColor)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(fillColor)
                .cornerRadius(15)
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Button")
        }
        .buttonStyle(PrimaryButtonStyle())
            .padding()
    }
}
