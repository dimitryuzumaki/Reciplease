//
//  CoreDataStack.swift
//  reciplease
//
//  Created by Dimitry Aumont on 12/01/2022.
//

import CoreData

open class CoreDataStack {
    
    // MARK: - Properties
    
    private let name: String
    
    // MARK: - Initializer
    
    public init(name: String) {
        self.name = name
    }
    
    // MARK: - Core Data stack
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}

