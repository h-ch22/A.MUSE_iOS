//
//  A_MUSEApp.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct A_MUSEApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

extension Color {
    static let backgroundColor = Color("background")
    static let accentColor = Color("AccentColor")
    static let txtColor = Color("txtColor")
    static let shadowStartColor = Color("shadowStart")
    static let shadowEndColor = Color("shadowEnd")
    static let btnStartColor = Color("btnStart")
    static let btnEndColor = Color("btnEnd")
}
