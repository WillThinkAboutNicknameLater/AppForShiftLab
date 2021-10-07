//
//  ProfileViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 05.10.2021.
//

import Combine
import FirebaseAuth

final class ProfileViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    @Published private(set) var name: String? = nil
    @Published private(set) var dateOfBirth: String? = nil
    
    @Published var error: AuthError?
    @Published var isLoading = false
    @Published var showingAlert = false
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        observeUser()
    }
    
    func tappedHelloButton() {
        showingAlert = true
    }
    
    func tappedSignOutButton() {
        isLoading = true
        userService.signOut().sink { [weak self] completion in
            self?.isLoading = false
            switch completion {
            case let .failure(error):
                print(error)
                self?.error = error
            case .finished:
                print("Finished")
                break
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)
    }
    
    private func observeUser() {
        userService.getCurrentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<UserDetailsModel, DefaultError> in
                return self.userService.observeUser(with: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { user in
                print(user)
                self.name = user.firstName + " " + user.lastName
                self.dateOfBirth = user.dateOfBirth.formatted(.dateTime.day().month().year())
            }.store(in: &cancellables)
    }
    
}
