//
//  RegistrationView.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var registrationData = RegistrationData()
    
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 24) {
            // This is deprecated. Ideally, I'd use a NavigationStack
            // instead of a NavigationView, but I'm not gonna bother
            // right now.
            NavigationLink(isActive: $isLoggedIn) {
                HomeView()
            } label: {
                EmptyView()
            }
            
            FormInput(label: "First Name*",
                      placeholder: "Enter your first name",
                      input: $registrationData.firstName)
            
            FormInput(label: "Last Name*",
                      placeholder: "Enter your last name",
                      input: $registrationData.lastName)
            
            FormInput(label: "Email*",
                      placeholder: "Enter your email address",
                      input: $registrationData.email)
            
            SubmitButton {
                registrationData.save(to: UserDefaults.standard)
                isLoggedIn = true
            }
            .disabled(!registrationData.isValid)
        }
        .padding()
    }
}

fileprivate struct FormInput: View {
    let label: String
    
    let placeholder: String
    
    @Binding var input: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .padding(.horizontal)
            
            TextField(placeholder, text: $input)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    Capsule()
                        .stroke(.black, lineWidth: 2)
                )
        }
    }
}

fileprivate struct SubmitButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Submit", action: action)
            .buttonStyle(.borderedProminent)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegistrationView()
        }
    }
}
