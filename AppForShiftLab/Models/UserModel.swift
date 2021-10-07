//
//  UserModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 05.10.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Codable {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var email: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName // = "sth"
        case lastName
        case dateOfBirth
        case email
        case password
    }
}
