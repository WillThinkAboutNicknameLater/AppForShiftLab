//
//  SignUpView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    
    var emailTextField: some View {
        TextField(viewModel.emailPlaceholderText, text: $viewModel.emailText)
            .modifier(TextFieldCustomStyle())
    }
    
    var passwordTextField: some View {
        SecureField(viewModel.passwordPlaceholderText, text: $viewModel.passwordText)
            .modifier(TextFieldCustomStyle())
    }
    
    var repeatPasswordTextField: some View {
        SecureField(viewModel.repeatPasswordPlaceholderText, text: $viewModel.repeatPasswordText)
            .modifier(TextFieldCustomStyle())
    }
    
    var firstNameTextField: some View {
        TextField(viewModel.firstNamePlaceholderText, text: $viewModel.firstNameText)
            .modifier(TextFieldCustomStyle())
    }
    
    var lastNameTextField: some View {
        TextField(viewModel.lastNamePlaceholderText, text: $viewModel.lastNameText)
            .modifier(TextFieldCustomStyle())
    }
    
    var datePicker: some View {
        DatePicker(viewModel.dateOfBirthPlaceholderText, selection: $viewModel.dateOfBirth, displayedComponents: [.date])
    }
    
    var signUpButton: some View {
        Button(action: {
            viewModel.tappedSignUpButton()
        }, label: {
            Text("Sign Up")
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
                
                VStack (spacing: 1) {
                    firstNameTextField
                    lastNameTextField
                }
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding()
                .errorView(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue?.localizedDescription != nil)) {
                    ErrorView(viewModel: .init(title: "Failed to sign up", error: viewModel.error, action: {
                        viewModel.error = nil
                    }))
                }
                
                datePicker
                    .padding(.horizontal, 30)
                
                VStack (spacing: 1) {
                    emailTextField
                    passwordTextField
                    repeatPasswordTextField
                }
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding()
                
                Spacer()
                signUpButton
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: .init(isPushed: .constant(false)))
    }
}
