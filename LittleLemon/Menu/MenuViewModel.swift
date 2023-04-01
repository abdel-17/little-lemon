//
//  MenuData.swift
//  LittleLemon
//
//  Created by Abdel on 29/03/2023.
//

import CoreData
import Foundation

@MainActor
class MenuViewModel: ObservableObject {
    @Published var searchQuery = ""
    
    @Published var selectedCategories = Set<DishCategory>()
    
    var sortDescriptors: [NSSortDescriptor] {
        [NSSortDescriptor(
            key: "title",
            ascending: true,
            selector: #selector(NSString.localizedCaseInsensitiveCompare))]
    }
    
    var predicate: NSPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: [
            // The predicate "title contains <empty string>" returns false,
            // so we first check if the searchQuery is empty before filtering
            // based on the title.
            searchQuery.isEmpty
                ? NSPredicate(value: true)
                : NSPredicate(format: "title CONTAINS[cd] %@", searchQuery),
            // Perform category-based filtering only if at least one is selected.
            selectedCategories.isEmpty
                ? NSPredicate(value: true)
                : NSPredicate(format: "category IN %@",
                              selectedCategories.map { category in category.rawValue })
        ])
    }
    
    /// Toggles the given category between selected and not selected.
    func toggle(category: DishCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    func loadMenu(context: NSManagedObjectContext) async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        do {
            let menu = try await Menu.json(url: url)
            try Dish.deleteAll(context: context)
            try Dish.create(from: menu, context: context)
        } catch {
            debugPrint("Error loading menu: \(error.localizedDescription)")
        }
    }
}


struct Menu: Codable {
    let items: [MenuItem]

    enum CodingKeys: String, CodingKey {
        case items = "menu"
    }

    /// Fetches menu data in JSON format from the given url.
    static func json(url: URL) async throws -> Menu {
        let (data, _) = try await URLSession.shared.data(from: url)
        let menu = try JSONDecoder().decode(Menu.self, from: data)
        debugPrint("Fetched menu from \(url)")
        return menu
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
    static func create(from menu: Menu, context: NSManagedObjectContext) throws {
        menu.items.forEach { item in
            let dish = Dish(context: context)
            dish.title = item.title
            dish.dishDescription = item.description
            dish.price = Float(item.price) ?? .nan
            dish.imageUrl = URL(string: item.image)
            dish.category = item.category
        }

        try context.save()
        debugPrint("Saved menu to CoreData")
    }

    /// Deletes all dishes from the given context.
    static func deleteAll(context: NSManagedObjectContext) throws {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Dish.fetchRequest())
        deleteRequest.resultType = .resultTypeObjectIDs

        let batchDelete = try context.execute(deleteRequest) as? NSBatchDeleteResult
        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }

        let deletedObjects: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deleteResult,
        ]
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [context]
        )
        debugPrint("Deleted all dishes from CoreData")
    }
}
