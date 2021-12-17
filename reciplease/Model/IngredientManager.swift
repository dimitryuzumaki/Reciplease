//
//  IngredientManager.swift
//  reciplease
//
//  Created by Birkyboy on 13/10/2021.
//

import Foundation


class IngredientManager {
    
    var ingredientList: [String] = []
    
    // Add
    func add(_ ingredient: String, completion: () -> Void) {
        ingredientList.append(ingredient)
        completion()
    }
    
    // Edit
    func edit(_ ingredient: String) {
        if let index = ingredientList.firstIndex(where: { $0 == ingredient }) {
            ingredientList[index] = ingredient
        }
    }
    
    // Delete
    func delete(_ ingredient: String) {
        if let index = ingredientList.firstIndex(where: { $0 == ingredient }) {
            ingredientList.remove(at: index)
        }
    }
    
    // Delete All
    func deleteAllIngredients(completion: () -> Void) {
        ingredientList.removeAll()
        completion()
    }
}
