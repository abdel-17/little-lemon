//
//  ContentView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        Group {
            if loginViewModel.isLoggedIn {
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                RegistrationView()
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: loginViewModel.isLoggedIn)
        .environmentObject(loginViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
