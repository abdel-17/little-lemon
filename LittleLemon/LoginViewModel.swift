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
    
    @Published var firstName: String {
        didSet {
            hasUnsavedChanges = true
        }
    }
    
    @Published var lastName: String {
        didSet {
            hasUnsavedChanges = true
        }
    }
    
    @Published var email: String {
        didSet {
            hasUnsavedChanges = true
        }
    }
    
    @Published private(set) var isLoggedIn: Bool
    
    @Published private(set) var hasUnsavedChanges = false
    
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
    func onLogin() {
        assert(isValid)
        isLoggedIn = true
        saveChanges()
        debugPrint("Logged in")
    }
    
    /// Logs out, resetting the current login state.
    func onLogout() {
        assert(isLoggedIn)
        firstName = ""
        lastName = ""
        email = ""
        isLoggedIn = false
        saveChanges()
        debugPrint("Logged out")
    }
    
    /// Sets the data in this view model to the data in `store`.
    func resetChanges() {
        firstName = store.string(forKey: Keys.firstName) ?? ""
        lastName = store.string(forKey: Keys.lastName) ?? ""
        email = store.string(forKey: Keys.email) ?? ""
        isLoggedIn = store.bool(forKey: Keys.isLoggedIn)
        hasUnsavedChanges = false
        debugPrint("Loaded from store")
    }
    
    /// Saves the data stored in this view model to `store`.
    func saveChanges() {
        store.set(firstName, forKey: Keys.firstName)
        store.set(lastName, forKey: Keys.lastName)
        store.set(email, forKey: Keys.email)
        store.set(isLoggedIn, forKey: Keys.isLoggedIn)
        hasUnsavedChanges = false
        debugPrint("Saved to store")
    }
}
