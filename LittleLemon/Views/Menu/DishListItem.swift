//
//  DishListItem.swift
//  LittleLemon
//
//  Created by Abdel on 31/03/2023.
//

import SwiftUI

struct DishListItem: View {
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.title!)
                    .font(.headline)
                
                Text(dish.category!)
                    .font(.subheadline)
                
                Text(dish.formattedPrice)
                    .padding(.top)
            }
            
            Spacer()
            
            NetworkImage(imageUrl: dish.imageUrl,
                         width: 160,
                         height: 100)
        }
    }
}

struct DishListItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                NavigationLink {
                    DishDetail(dish: .preview)
                } label: {
                    DishListItem(dish: .preview)
                }
            }
            .listStyle(.plain)
        }
    }
}
