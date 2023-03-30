//
//  DishView.swift
//  LittleLemon
//
//  Created by Abdel on 30/03/2023.
//

import SwiftUI

struct DishView: View {
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.title ?? "")
                    .font(.headline)
                
                Text(dish.category ?? "")
                    .font(.subheadline)
                
                Text(String(format: "%.2f $", dish.price))
                    .padding(.top)
            }
            
            Spacer(minLength: 24)
            
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150)
        }
        .padding(.vertical)
    }
}

struct DishView_Previews: PreviewProvider {
    static let dish = {
        let dish = Dish(context: PersistenceController.preview.container.viewContext)
        dish.title = "Greek Salad"
        dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.category = "starters"
        dish.price = 10
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        return dish
    }()
    
    static var previews: some View {
        DishView(dish: dish)
    }
}

