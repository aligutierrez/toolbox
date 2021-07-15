//
//  ToolboxApp.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/9/21.
//

import SwiftUI

@main
struct ToolboxApp: App {
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(loginViewModel)
        }
    }
  }
