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
    
    @Published var firstName: String
    
    @Published var lastName: String
    
    @Published var email: String
    
    @Published private(set) var isLoggedIn: Bool
    
    private struct Keys {
        static let firstName = "firstName"
        
        static let lastName = "lastName"
        
        static let email = "email"
        
        static let isLoggedIn = "isLoggedIn"
    }
    
    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
        self.firstName = store.string(forKey: Keys.firstName) ?? ""
        self.lastName = store.string(forKey: Keys.lastName) ?? ""
        self.email = store.string(forKey: Keys.email) ?? ""
        self.isLoggedIn = store.bool(forKey: Keys.isLoggedIn)
    }
    
    /// The full name retrieved from the current login state.
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    /// Returns `true` if the current login state is valid.
    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        email.wholeMatch(of: emailRegex) != nil
    }
    
    private let emailRegex = try! Regex("^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$")
    
    /// Logs in using the current login state.
    ///
    /// The data must be valid.
    func login() {
        assert(isValid)
        isLoggedIn = true
        syncStore()
        debugPrint("Logged in")
    }
    
    /// Logs out, resetting the current login state.
    func logout() {
        assert(isLoggedIn)
        firstName = ""
        lastName = ""
        email = ""
        isLoggedIn = false
        syncStore()
        debugPrint("Logged out")
    }
    
    /// Syncs the data stored in `store` with the current state.
    private func syncStore() {
        store.set(firstName, forKey: Keys.firstName)
        store.set(lastName, forKey: Keys.lastName)
        store.set(email, forKey: Keys.email)
        store.set(isLoggedIn, forKey: Keys.isLoggedIn)
    }
}
