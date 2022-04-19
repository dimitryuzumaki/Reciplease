//
//  CoreDataManager.swift
//  reciplease
//
//  Created by Dimitry Aumont on 12/01/2022.
//

import CoreData
final class CoreDataManager {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func createRecipe(recipe: RecipeDetails) {
        let recipesEntity = RecipeEntity  (context: managedObjectContext)
        recipesEntity.name = recipe.name
        recipesEntity.ingredients = recipe.ingredients
        recipesEntity.calories = recipe.calories
        recipesEntity.url = recipe.url
        recipesEntity.image = recipe.image
        coreDataStack.saveContext()
        
    }
    func deleteRecipe(name: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let recipes = try? managedObjectContext.fetch(request) else { return }
        guard let recipe = recipes.first else { return }
        managedObjectContext.delete(recipe)
        coreDataStack.saveContext()
        
    }
    func isRecipeExist(name: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let recipes  = try? managedObjectContext.fetch(request) else {return false}
        if recipes.isEmpty {return false}
        return true
    }
    
}

