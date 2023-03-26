//
//  ContentView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            if let registrationData = RegistrationData.load(from: UserDefaults.standard) {
                // Placeholder until main view is implemented
                EmptyView()
            } else {
                OnboardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
