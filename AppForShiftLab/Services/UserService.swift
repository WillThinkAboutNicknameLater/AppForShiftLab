//
//  UserService.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol UserServiceProtocol {
    func getCurrentUserPublisher() -> AnyPublisher<User?, Never>
    func signUp(with userModel: UserModel) -> AnyPublisher<Void, AuthError>
    func signIn(email: String, password: String) -> AnyPublisher<Void, AuthError>
    func signOut() -> AnyPublisher<Void, AuthError>
    func observeAuthChanges() -> AnyPublisher<User?, Never>
    func observeUser(with userid: String) -> AnyPublisher<UserDetailsModel, DefaultError>
}

final class UserService: UserServiceProtocol {
    let db = Firestore.firestore()
    
    func getCurrentUserPublisher() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signUp(with userModel: UserModel) -> AnyPublisher<Void, AuthError> {
        return Future<Void, AuthError> { promise in
            Auth.auth().createUser(withEmail: userModel.email, password: userModel.password) {
                result, error in
                if let error = error {
                    promise(.failure(.failedToSignUp(description: error.localizedDescription)))
                } else if let uid = result?.user.uid {
                    let userDetails = [UserModel.CodingKeys.firstName.rawValue: userModel.firstName,
                                       UserModel.CodingKeys.lastName.rawValue: userModel.lastName,
                                       UserModel.CodingKeys.dateOfBirth.rawValue: userModel.dateOfBirth] as [String: Any]
                    let _ = self.db.collection("users").document(uid).setData(userDetails) { error in
                        if let error = error {
                            promise(.failure(.failedToSignUp(description: error.localizedDescription)))
                        } else {
                            promise(.success(()))
                        }
                    }
                } else {
                    promise(.failure(.failedToSignUp(description: "Invalid user ID")))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<Void, AuthError> {
        return Future<Void, AuthError> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.failure(.failedToSignIn(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Void, AuthError> {
        return Future<Void, AuthError> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(()))
            } catch {
                promise(.failure(.failedToSignOut(description: error.localizedDescription)))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    func observeUser(with userId: String) -> AnyPublisher<UserDetailsModel, DefaultError> {
        return Future<UserDetailsModel, DefaultError> { promise in
            self.db.collection("users").document(userId).addSnapshotListener { snapshot, error in
                if let snapshot = snapshot {
                    do {
                        if let user = try snapshot.data(as: UserDetailsModel.self) {
                            promise(.success(user))
                        }
                    } catch {
                        promise(.failure(.default(description: "Parsing error")))
                    }
                }
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                }
            }
        }.eraseToAnyPublisher()
    }
}
