//
//  LandingView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 22, weight: .heavy))
    }
    
    var signInButton: some View {
        //                Button(action: {
        //                    viewModel.signInPushed = true
        //                }, label: {
        //                    Text("Sign In")
        //                })
        //                    .buttonStyle(PrimaryButtonStyle())
        //                    .sheet(isPresented: $viewModel.signInPushed) {
        //                    SignInView(viewModel: .init(isPushed: $viewModel.signInPushed))
        //                }
        NavigationLink(destination: SignInView(viewModel: .init(isPushed: $viewModel.signInPushed)), isActive: $viewModel.signInPushed) {
            Button(action: {
                viewModel.signInPushed = true
            }, label: {
                Text("Sign In")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(15)
            })
        }
    }
    
    var signUpButton: some View {
        //        Button(action: {
        //            viewModel.signUpPushed = true
        //        }, label: {
        //            Text("Sign Up")
        //                .padding()
        //                .frame(maxWidth: .infinity)
        //                .foregroundColor(.black)
        //                .cornerRadius(15)
        //        }).sheet(isPresented: $viewModel.signUpPushed) {
        //            SignUpView(viewModel: .init(isPushed: $viewModel.signUpPushed))
        //        }
        
        NavigationLink(destination: SignUpView(viewModel: .init(isPushed: $viewModel.signUpPushed)), isActive: $viewModel.signUpPushed) {
            Button(action: {
                viewModel.signUpPushed = true
            }, label: {
                Text("Sign Up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .cornerRadius(15)
            })
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                title
                Spacer()
                LogoView()
                Spacer()
                signInButton
                    .padding(.horizontal)
                signUpButton
                    .padding([.leading, .bottom, .trailing])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
