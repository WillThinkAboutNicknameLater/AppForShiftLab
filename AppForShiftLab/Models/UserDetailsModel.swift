//
//  UserDetailsModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 07.10.2021.
//

import Foundation
import FirebaseFirestoreSwift

struct UserDetailsModel: Codable {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case dateOfBirth
    }
}
