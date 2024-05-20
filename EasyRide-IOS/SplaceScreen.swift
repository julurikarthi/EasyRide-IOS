//
//  ContentView.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/3/24.
//

import SwiftUI

struct SplaceScreen: View {
    @State private var isNextViewActive = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("test") {
                    isNextViewActive = true
                }
            }.navigationDestination(isPresented: $isNextViewActive) {
                SignUpView()
            }.onAppear(perform: {
                
            }).frame(maxWidth: .infinity,maxHeight: .infinity).background(Color(hex: AppColors.backGroundColor.rawValue)).edgesIgnoringSafeArea(.all)
        }
     
    }
}

#Preview {
    SplaceScreen()
}
