//
//  ProfileTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Personal Information")
                .font(.title)
                .bold()
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(maxWidth: 150, maxHeight: 150)
                .clipShape(Circle())
            
            TitledText(title: "Full Name",
                       description: loginViewModel.fullName)
                
            TitledText(title: "Email address",
                       description: loginViewModel.email)
            
            Button("Logout") {
                loginViewModel.logout()
            }
            .lemonStyle()
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

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
            .environmentObject(LoginViewModel())
    }
}
