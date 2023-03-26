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
                // Placeholder until the main view is implemented
                EmptyView()
            } else {
                RegistrationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
