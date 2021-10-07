//
//  SignUpViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import Foundation
import Combine
import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var repeatPasswordText = ""
    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var dateOfBirth = Date()
    
    private(set) var emailPlaceholderText = "Email"
    private(set) var passwordPlaceholderText = "Password"
    private(set) var repeatPasswordPlaceholderText = "Repeat password"
    private(set) var firstNamePlaceholderText = "First name"
    private(set) var lastNamePlaceholderText = "Last name"
    private(set) var dateOfBirthPlaceholderText = "Date of Birth"
    
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
    
    func tappedSignUpButton() {
        isLoading = true
        let user = UserModel(firstName: firstNameText, lastName: lastNameText, dateOfBirth: dateOfBirth, email: emailText, password: passwordText)
        userService.signUp(with: user).sink { [weak self] completion in
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

extension SignUpViewModel {
    
    private var isValidNamePublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($firstNameText, $lastNameText)
            .map { firstName, lastName in
                return firstName.count > 1 && lastName.count > 1
            }
            .eraseToAnyPublisher()
    }
    
    private var isValidDateOfBirthPublisher: AnyPublisher<Bool, Never> {
        $dateOfBirth
            .removeDuplicates()
            .map { dateOfBirth in
                return dateOfBirth <= Date()
            }
            .eraseToAnyPublisher()
    }
    
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
    
    private var areValidPasswordsPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($passwordText, $repeatPasswordText)
            .map { password, repeatPassword in
                return password.count > 5 && password == repeatPassword
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isValidNamePublisher, isValidDateOfBirthPublisher, isValidEmailPublisher, areValidPasswordsPublisher)
            .map { nameIsValid, dateOfBirthIsValid, emailIsValid, passwordsAreValid in
                return nameIsValid && dateOfBirthIsValid && emailIsValid && passwordsAreValid
            }
            .eraseToAnyPublisher()
    }
    
}
