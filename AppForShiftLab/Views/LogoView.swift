//
//  LogoView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image(systemName: "atom")
            .font(.system(size: 35, weight: .regular))
            .padding()
            .foregroundColor(.white)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
