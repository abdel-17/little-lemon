//
//  MenuTab.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct MenuTab: View {
    @Environment(\.managedObjectContext) var viewContext

    @State private var query = ""

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Little Lemon")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                Text("Chicago")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.bottom)

                Text("Little Lemon is a charming neighborhood bistro that serves simple food and classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                
                TextField("Search for a dish", text: $query)
                    .lemonStyle()
                    .padding(.top)
            }
            .padding(.horizontal)

            DishList(sortDescriptors: sortDescriptors, predicate: predicate)
        }
        .task {
            await loadDishes()
        }
    }

    private var sortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    }

    private var predicate: NSPredicate {
        guard !query.isEmpty else {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", query)
    }

    private func loadDishes() async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        do {
            let menu = try await Menu.json(url: url)
            try Dish.deleteAll(context: viewContext)
            try Dish.create(from: menu, context: viewContext)
        } catch {
            debugPrint("Error loading menu: \(error.localizedDescription)")
        }
    }
}

struct MenuTab_Previews: PreviewProvider {
    static var previews: some View {
        MenuTab()
    }
}
