//
//  HomeView.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    var body: some View {
        TabView {
            MenuTab()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            ProfileTab()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var viewModel: LoginViewModel {
        let viewModel = LoginViewModel()
        viewModel.loginData = LoginData(
            firstName: "Ahmed",
            lastName: "Mohamed",
            email: "ahmedmohamed@gmail.com"
        )
        return viewModel
    }
    
    static var previews: some View {
        HomeView()
            .environmentObject(viewModel)
    }
}
