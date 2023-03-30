//
//  MenuData.swift
//  LittleLemon
//
//  Created by Abdel on 29/03/2023.
//

import Foundation
import CoreData

struct Menu: Codable {
    let items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "menu"
    }
    
    /// Fetches menu data in JSON format from the given url.
    static func json(url: URL) async throws -> Menu {
        debugPrint("Fetching menu from \(url)")
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Menu.self, from: data)
    }
}

struct MenuItem: Codable {
    let title: String
    
    let description: String
    
    let price: String
    
    let image: String
    
    let category: String
}

extension Dish {
    /// Saves the menu items as dishes to the given context.
    static func create(from menu: Menu, context: NSManagedObjectContext) {
        menu.items.forEach { item in
            let dish = Dish(context: context)
            dish.title = item.title
            dish.dishDescription = item.description
            dish.price = Float(item.price) ?? .nan
            dish.image = item.image
            dish.category = item.category
        }
        
        do {
            try context.save()
        } catch {
            debugPrint("Saving context changes failed: \(error.localizedDescription)")
        }
    }
}

