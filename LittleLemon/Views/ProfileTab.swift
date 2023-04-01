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
        NavigationView {
            VStack(spacing: 24) {
                HStack {
                    Text("Profile")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                LabeledTextField(
                    label: "First name",
                    placeholder: "Enter your first name",
                    text: $loginViewModel.firstName)
                
                LabeledTextField(
                    label: "Last name",
                    placeholder: "Enter your first last",
                    text: $loginViewModel.lastName)
                
                LabeledTextField(
                    label: "Email address",
                    placeholder: "Enter your email address",
                    text: $loginViewModel.email)
                
                HStack(spacing: 32) {
                    Button("Cancel") {
                        loginViewModel.resetChanges()
                    }
                    .foregroundColor(.olive)
                    
                    Button("Save") {
                        loginViewModel.saveChanges()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.olive)
                    .disabled(!loginViewModel.isValid)
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Button {
                        loginViewModel.onLogout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .onDisappear {
                // Cancel automatically if the user leaves without saving.
                if loginViewModel.hasUnsavedChanges {
                    loginViewModel.resetChanges()
                }
            }
        }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
            .environmentObject(LoginViewModel())
    }
}
