//
//  ProfileView.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 05.10.2021.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    
    var profileImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.system(size: 100, weight: .regular))
            .foregroundColor(.black)
    }
    
    var name: some View {
        Text(viewModel.name ?? "Name")
            .font(.system(.headline))
    }
    
    var dateOfBirth: some View {
        Text(viewModel.dateOfBirth ?? "Date of Birth")
    }
    
    var helloButton: some View {
        Button(action: {
            viewModel.tappedHelloButton()
        }, label: {
            Image(systemName: "hand.wave")
                .font(.system(size: 35, weight: .regular))
                .padding()
                .foregroundColor(.white)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        })
            .alert("Hello, " + (viewModel.name ?? "stranger") + "!", isPresented: $viewModel.showingAlert) {
                Button("Hi", role: .cancel) { }
            }
        
    }
    
    var signOutButton: some View {
        Button(action: {
            viewModel.tappedSignOutButton()
        }) {
            Text("Sign Out")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(15)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    profileImage
                        .padding()
                    name
                        .padding()
                    dateOfBirth
                    Spacer()
                    helloButton
                    Spacer()
                    signOutButton
                        .padding()
                        .errorView(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue?.localizedDescription != nil)) {
                            ErrorView(viewModel: .init(title: "Failed to sign out", error: viewModel.error, action: {
                                viewModel.error = nil
                            }))
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Profile")
                
                if (viewModel.isLoading) {
                    CustomProgressView()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
