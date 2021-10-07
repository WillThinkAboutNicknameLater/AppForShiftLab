//
//  DefaultError.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 07.10.2021.
//

import Foundation

enum DefaultError: LocalizedError {
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .default(description):
            return description ?? "Something went wrong"
        }
    }
}
