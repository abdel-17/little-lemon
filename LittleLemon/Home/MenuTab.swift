//
//  MenuTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct MenuTab: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
                .bold()
            
            Text("Chicago")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Little Lemon is a charming neighborhood bistro thatserves simple food and classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                .padding(.top, 8)
        }
        .padding()
    }
}

struct MenuTab_Previews: PreviewProvider {
    static var previews: some View {
        MenuTab()
    }
}
