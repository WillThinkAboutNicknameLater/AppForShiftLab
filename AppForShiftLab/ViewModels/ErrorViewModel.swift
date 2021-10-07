//
//  ErrorViewModel.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 06.10.2021.
//

import Foundation
import SwiftUI

final class ErrorViewModel: ObservableObject {
    private(set) var title: String
    private(set) var error: Error?
    private var action: () -> Void
    
    init(title: String, error: Error?, action: @escaping () -> Void) {
        self.title = title
        self.error = error
        self.action = action
    }
    
    func tappedCloseButton() {
        action()
    }
    
}

