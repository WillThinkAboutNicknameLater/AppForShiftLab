//
//  AppForShiftLabApp.swift
//  AppForShiftLab
//
//  Created by Mackem Meya on 04.10.2021.
//

import SwiftUI
import Firebase

@main
struct AppForShiftLabApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDeleagate
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if (appState.isSignedIn) {
                TabContainerView()
            } else {
                LandingView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

class AppState: ObservableObject {
    @Published private(set) var isSignedIn = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isSignedIn)
    }
}
