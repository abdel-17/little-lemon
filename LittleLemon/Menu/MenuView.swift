//
//  MenuView.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) var viewContext

    @State private var query = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Little Lemon")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                    
                    Text("Chicago")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text("Little Lemon is a charming neighborhood bistro that serves simple food and classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                        .padding(.vertical)
                        .foregroundColor(.white)
                    
                    TextField(
                        "Search",
                        text: $query,
                        prompt: Text("Search for a dish")
                            .foregroundColor(.white)
                    )
                    .lemonStyle(blurredStrokeColor: .white)
                }
                .padding()
                .background(Color("olive"))
                
                DishList(sortDescriptors: sortDescriptors, predicate: predicate)
            }
            .task {
                await loadDishes()
            }
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
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
