//
//  SignInView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    
    var emailTextField: some View {
        TextField(viewModel.emailPlaceholderText, text: $viewModel.emailText)
            .modifier(TextFieldCustomStyle())
    }
    
    var passwordTextField: some View {
        SecureField(viewModel.passwordPlaceholderText, text: $viewModel.passwordText)
            .modifier(TextFieldCustomStyle())
    }
    
    var signInButton: some View {
        Button(action: {
            viewModel.tappedSignInButton()
        }, label: {
            Text("Sign In")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(15)
        })
            .disabled(!viewModel.isValid)
            .opacity(viewModel.isValid ? 1 : 0.5)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                LogoView()
                Spacer()
                
                VStack(spacing: 1.0) {
                    emailTextField
                    passwordTextField
                }
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding()
                .errorView(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue?.localizedDescription != nil)) {
                    ErrorView(viewModel: .init(title: "Failed to sign in", error: viewModel.error, action: {
                        viewModel.error = nil
                    }))
                }
                
                Spacer()
                signInButton
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                viewModel.isPushed = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.black)
            })
            
            if (viewModel.isLoading) {
                CustomProgressView()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: .init(isPushed: .constant(false)))
    }
}
