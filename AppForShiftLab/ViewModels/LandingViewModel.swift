//
//  LandingViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import Foundation
import SwiftUI

final class LandingViewModel: ObservableObject {
    @Published var signUpPushed = false
    @Published var signInPushed = false
    
    private(set) var title = "Shift Lab"
}
