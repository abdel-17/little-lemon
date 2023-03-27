//
//  ContentView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            if RegistrationData.load(from: UserDefaults.standard) != nil {
                HomeView()
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
