//
//  ErrorView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import SwiftUI

struct ErrorView: View {
    var viewModel: ErrorViewModel
    
    var title: some View {
        Text("Failed to sign in")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.red)
            .multilineTextAlignment(.leading)
    }
    
    var closeButton: some View {
        Button(action: {
            viewModel.tappedCloseButton()
        }, label: {
            Image(systemName: "xmark.circle")
                .foregroundColor(.red)
        })
    }
    
    var description: some View {
        Text(viewModel.error?.localizedDescription ?? "Something went wrong...")
            .font(.system(size: 12))
            .foregroundColor(.red)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                title
                Spacer()
                closeButton
            }
            .padding([.top, .leading, .trailing])
            
            HStack {
                description
                Spacer()
            }
            .padding([.leading, .bottom, .trailing])
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 252 / 255, green: 236 / 255, blue: 234 / 255, opacity: 1))
        .cornerRadius(15)
        .padding(.horizontal)
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: .init(title: "Title", error: AuthError.failedToSignIn(description: "Error"), action: {}))
    }
}
