//
//  RecipeTableViewCell.swift
//  reciplease
//
//  Created by Dimitry Aumont on 10/11/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var IngredientDetail: UILabel!
    
    @IBOutlet weak var nameOfRecipe: UILabel!
    
    @IBOutlet weak var calorieData: UILabel!
      
    
    var recipe: Recipe?{
        didSet{
            if let imageURL = recipe?.image, let url = URL(string: imageURL) {  recipeImage.load(url: url) }
            nameOfRecipe.text = recipe?.label
            calorieData.text = "\(recipe?.calories ?? 0)"
            IngredientDetail.text = recipe?.ingredientLines.joined(separator: ", ")
            
            
        }
    }
    }
    

