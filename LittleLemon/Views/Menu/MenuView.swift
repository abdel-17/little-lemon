//
//  MenuView.swift
//  LittleLemon
//
//  Created by Abdel on 30/03/2023.
//

import SwiftUI

struct MenuView: View {
    @FetchRequest private var dishes: FetchedResults<Dish>
    
    init(sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil) {
        _dishes = FetchRequest(sortDescriptors: sortDescriptors, predicate: predicate)
    }
    
    var body: some View {
        List {
            ForEach(dishes) { dish in
                NavigationLink {
                    DishDetail(dish: dish)
                } label: {
                    DishListItem(dish: dish)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
