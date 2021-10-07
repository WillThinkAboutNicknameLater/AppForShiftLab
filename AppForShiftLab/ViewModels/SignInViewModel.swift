//
//  SignInViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 05.10.2021.
//

import Foundation
import Combine
import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    
    private(set) var emailPlaceholderText = "Email"
    private(set) var passwordPlaceholderText = "Password"
    
    @Published var error: AuthError?
    @Published var isLoading = false
    @Published var isValid = false
    @Binding var isPushed: Bool
    
    private var cancellables: [AnyCancellable] = []
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService(), isPushed: Binding<Bool>) {
        self.userService = userService
        self._isPushed = isPushed
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$isValid)
    }
    
    func tappedSignInButton() {
        isLoading = true
        userService.signIn(email: emailText, password: passwordText).sink { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case let .failure(error):
                print(error)
                self?.error = error
            case .finished:
                print("Finished")
                self?.isPushed = false
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)

    }
}

extension SignInViewModel {
    private var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $emailText
            .removeDuplicates()
            .map { email in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email) && email.count > 5
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $passwordText
            .removeDuplicates()
            .map { password in
                return password.count > 5
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidEmailPublisher, isValidPasswordPublisher)
            .map { emailIsValid, passwordIsValid in
                return emailIsValid && passwordIsValid
            }
            .eraseToAnyPublisher()
    }
}
