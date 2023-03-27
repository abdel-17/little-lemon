//
//  ProfileTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct ProfileTab: View {
    @Environment(\.presentationMode) var presentationMode
    
    let registrationData: RegistrationData
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Personal information")
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(maxWidth: 150, maxHeight: 150)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("First name: \(registrationData.firstName)")
                
                Text("Last name: \(registrationData.lastName)")
                
                Text("Email address: \(registrationData.email)")
            }
            
            Button("Logout") {
                RegistrationData.delete(from: UserDefaults.standard)
                // Navigate back to the login screen.
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab(registrationData: .fake)
    }
}
