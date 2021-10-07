//
//  ProgressViewCustomStyle.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 5)
                .frame(width: 75, height: 75)
            ProgressView()
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
