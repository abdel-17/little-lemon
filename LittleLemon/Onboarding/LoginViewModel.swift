//
//  LoginViewModel.swift
//  LittleLemon
//
//  Created by Abdel on 30/03/2023.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    let store: UserDefaults
    
    @Published var loginData: LoginData
    
    @Published private(set) var isLoggedIn: Bool
    
    private struct Keys {
        static let firstName = "firstName"
        
        static let lastName = "lastName"
        
        static let email = "email"
        
        static let isLoggedIn = "isLoggedIn"
    }
    
    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
        self.loginData = LoginData(
            firstName: store.string(forKey: Keys.firstName) ?? "",
            lastName: store.string(forKey: Keys.lastName) ?? "",
            email: store.string(forKey: Keys.email) ?? ""
        )
        self.isLoggedIn = store.bool(forKey: Keys.isLoggedIn)
    }
    
    /// Logs in using the current login state.
    ///
    /// The data must be valid.
    func onLogin() {
        assert(loginData.isValid)
        isLoggedIn = true
        saveChanges()
        debugPrint("Logged in")
    }
    
    /// Logs out, resetting the current login state.
    func onLogout() {
        assert(isLoggedIn)
        loginData = LoginData()
        isLoggedIn = false
        saveChanges()
        debugPrint("Logged out")
    }
    
    /// Saves the data stored in this view model to `store`.
    func saveChanges() {
        store.set(loginData.firstName, forKey: Keys.firstName)
        store.set(loginData.lastName, forKey: Keys.lastName)
        store.set(loginData.email, forKey: Keys.email)
        store.set(isLoggedIn, forKey: Keys.isLoggedIn)
        debugPrint("Saved to store")
    }
}
