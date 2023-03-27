//
//  HomeView.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct HomeView: View {
    let registrationData: RegistrationData
    
    var body: some View {
        TabView {
            MenuTab()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            ProfileTab(registrationData: registrationData)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        // Hide the back button to prevent the user from going
        // back to the registration screen.
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(registrationData: .fake)
    }
}
