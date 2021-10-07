//
//  AuthError.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import Foundation

enum AuthError: LocalizedError {
    case failedToSignUp(description: String)
    case failedToSignIn(description: String)
    case failedToSignOut(description: String)
    
    var errorDescription: String? {
        switch self {
        case let .failedToSignUp(description):
            return description
        case let .failedToSignIn(description):
            return description
        case let .failedToSignOut(description):
            return description
        }
    }
}
