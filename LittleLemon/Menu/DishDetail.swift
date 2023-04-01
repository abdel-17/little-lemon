//
//  DishDetail.swift
//  LittleLemon
//
//  Created by Abdel on 31/03/2023.
//

import SwiftUI

struct DishDetail: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(dish.title!)
                .font(.title)
                .bold()
            
            HStack {
                Text(dish.category!)
                
                Spacer()
                
                Text(dish.formattedPrice)
            }
            .font(.headline)
            
            HStack {
                Spacer()
                
                NetworkImage(imageUrl: dish.imageUrl,
                             width: 320,
                             height: 200)
                .padding(.vertical)
                
                Spacer()
            }
            
            Text(dish.dishDescription!)
            
            Spacer()
        }
        .padding()
    }
}

struct DishDetail_Previews: PreviewProvider {
    static var previews: some View {
        DishDetail(dish: .preview)
    }
}
