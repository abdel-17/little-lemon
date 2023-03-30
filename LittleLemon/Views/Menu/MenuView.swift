//
//  MenuView.swift
//  LittleLemon
//
//  Created by Abdel on 30/03/2023.
//

import SwiftUI

struct MenuView: View {
    @FetchRequest
    private var dishes: FetchedResults<Dish>
    
    init(sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil) {
        _dishes = FetchRequest(sortDescriptors: sortDescriptors, predicate: predicate)
    }
    
    var body: some View {
        ForEach(dishes) { dish in
            HStack {
                VStack(alignment: .leading) {
                    Text(dish.title!)
                        .font(.headline)
                    
                    Text(dish.category!)
                        .font(.subheadline)
                    
                    Text(String(format: "%.2f $", dish.price))
                        .padding(.top)
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: dish.image!)) { image in
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
        // Remove the list padding
        .listRowInsets(EdgeInsets())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
