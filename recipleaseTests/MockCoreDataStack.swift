//
//  MockCoreDataStack.swift
//  recipleaseTests
//
//  Created by Dimitry Aumont on 15/03/2022.
//

import Foundation
import CoreData
import reciplease



final class MockCoreDataStack: CoreDataStack {

    // MARK: - Initializer

    convenience init() {
        self.init(name: "reciplease")
    }

    override init(name: String) {
        super.init(name: name)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: name)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
