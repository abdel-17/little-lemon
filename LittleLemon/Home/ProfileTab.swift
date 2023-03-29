//
//  ProfileTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct ProfileTab: View {
    @Environment(\.dismiss) var dismiss
    
    let registrationData: RegistrationData
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Personal Information")
                .font(.title)
                .bold()
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(maxWidth: 150, maxHeight: 150)
                .clipShape(Circle())
            
            TitledText(title: "Name",
                       description: "\(registrationData.firstName) \(registrationData.lastName)")
                
            TitledText(title: "Email address",
                       description: registrationData.email)
            
            LogoutButton(dismiss: dismiss)
                .padding(.top)
        }
        .padding()
    }
}

fileprivate struct TitledText: View {
    let title: String
    
    let description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(description)
            }
            Spacer()
        }
    }
}

fileprivate struct LogoutButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    let dismiss: DismissAction
    
    var body: some View {
        Button("Logout") {
            RegistrationData.delete(from: UserDefaults.standard)
            // Navigate back to the login screen.
            dismiss()
        }
        .foregroundColor(colorScheme == .dark ? .black : .white)
        .buttonStyle(.borderedProminent)
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab(registrationData: .fake)
    }
}
