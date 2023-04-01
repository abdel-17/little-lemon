//
//  Persistence.swift
//  LittleLemon
//
//  Created by Abdel on 26/03/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LittleLemon")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension PersistenceController {
    static var preview: PersistenceController {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        Dish.createPreview(context: viewContext)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }
}

extension Dish {
    static var preview: Dish {
        Dish.createPreview(context: PersistenceController.preview.container.viewContext)
    }
    
    @discardableResult
    fileprivate static func createPreview(context: NSManagedObjectContext) -> Dish {
        let dish = Dish(context: context)
        dish.title = "Greek Salad"
        dish.dishDescription = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.price = 10.0
        dish.imageUrl = URL(string: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true")
        dish.category = "starters"
        return dish
    }
}
