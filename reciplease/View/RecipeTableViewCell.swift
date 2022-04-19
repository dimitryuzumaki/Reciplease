//
//  RecipeTableViewCell.swift
//  reciplease
//
//  Created by Dimitry Aumont on 10/11/2021.
//

import UIKit
import CoreData

class RecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var IngredientDetail: UILabel!
    
    @IBOutlet weak var nameOfRecipe: UILabel!
    
    @IBOutlet weak var calorieData: UILabel!
    
    func configure(with recipe: RecipeDetails) {
        DispatchQueue.global(qos: .background).async {
            if let image = self.recipeImage.fetchImage(from: recipe.image){
                DispatchQueue.main.async {
                    self.recipeImage.image = image
                }
            }
        }
        nameOfRecipe.text = recipe.name
        calorieData.text = recipe.calories + "Kcal"
        IngredientDetail.text = recipe.ingredients.joined(separator: ", ")

    }
    func configure(with recipe: RecipeEntity){
        DispatchQueue.global(qos: .background).async {
            if let image = self.recipeImage.fetchImage(from: recipe.image){
                DispatchQueue.main.async {
                    self.recipeImage.image = image
                }
            }
        }
        nameOfRecipe.text = recipe.name
        calorieData.text = recipe.calories
        IngredientDetail.text = recipe.ingredients!.joined(separator: ", ")
    }
}



