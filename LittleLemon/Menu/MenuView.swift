//
//  MenuView.swift
//  LittleLemon
//
//  Created by Abdel on 27/03/2023.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) var viewContext

    @StateObject private var viewModel = MenuViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
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
                        text: $viewModel.searchQuery,
                        prompt: Text("Search for a dish")
                            .foregroundColor(.white)
                    )
                    .lemonStyle(blurredStrokeColor: .white)
                }
                .padding()
                .background(Color("olive"))
                
                VStack(alignment: .leading) {
                    Text("Order for Delivery!")
                        .font(.title3)
                        .bold()
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(DishCategory.allCases) { category in
                                DishCategoryView(viewModel: viewModel,
                                                 category: category)
                            }
                        }
                    }
                }
                .padding()
                
                Divider()
                
                DishList(sortDescriptors: viewModel.sortDescriptors,
                         predicate: viewModel.predicate)
            }
            .task {
                await viewModel.loadMenu(context: viewContext)
            }
        }
    }
}

enum DishCategory: String, CaseIterable, Identifiable {
    case starters, mains, desserts, drinks
    
    var id: Self { self }
}

private struct DishCategoryView: View {
    @ObservedObject var viewModel: MenuViewModel
    
    let category: DishCategory
    
    var body: some View {
        Button(category.rawValue.capitalized) {
            withAnimation(.easeOut(duration: 0.25)) {
                viewModel.toggle(category: category)
            }
        }
        .bold()
        .tint(isSelected ? .olive : .secondary.opacity(0.35))
        .foregroundColor(isSelected ? .white : .primary)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
    
    var isSelected: Bool {
        viewModel.selectedCategories.contains(category)
    }
}

struct MenuTab_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
