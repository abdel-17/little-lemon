//
//  ProfileTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    @FocusState private var focused
    
    @State private var loginData = LoginData()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                LabeledTextField(
                    label: "First name",
                    placeholder: "Enter your first name",
                    text: $loginData.firstName)
                .focused($focused)
                
                LabeledTextField(
                    label: "Last name",
                    placeholder: "Enter your first last",
                    text: $loginData.lastName)
                .padding(.vertical)
                .focused($focused)
                
                LabeledTextField(
                    label: "Email address",
                    placeholder: "Enter your email address",
                    text: $loginData.email)
                .focused($focused)
                .emailTextField()
                
                HStack(spacing: 32) {
                    Button("Cancel") {
                        onCancel()
                    }
                    .foregroundColor(hasChanges ? .olive : nil)
                    .disabled(!hasChanges)
                    
                    Button("Save") {
                        onSave()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.olive)
                    .disabled(!hasChanges || !loginData.isValid)
                }
                .padding(.top, 24)
                
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
            .navigationTitle("Profile")
            .onAppear {
                loginData = loginViewModel.loginData
            }
        }
    }
    
    /// Returns `true` if the user made any changes to the login data.
    private var hasChanges: Bool {
        loginData != loginViewModel.loginData
    }
    
    private func onCancel() {
        loginData = loginViewModel.loginData
        focused = false
    }
    
    private func onSave() {
        loginViewModel.loginData = loginData
        loginViewModel.saveChanges()
        focused = false
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
            .environmentObject(LoginViewModel())
    }
}
