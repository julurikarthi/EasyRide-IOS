//
//  EasyRide_IOSApp.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import SwiftUI

@main
struct EasyRide_IOSApp: App {
    @Environment(\.presentationMode) var presentationMode
    let appState = AppState()
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: AppColors.backGroundColor.rawValue)
        UINavigationBar.appearance().standardAppearance = appearance;
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }
    var body: some Scene {
        WindowGroup {
            SplaceScreen().environment(appState)
        }
    }
}
