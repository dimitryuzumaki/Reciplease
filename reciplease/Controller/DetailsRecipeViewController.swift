//
//  DetailsRecipeViewController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 15/12/2021.
//

import UIKit


class DetailsRecipesViewController: UIViewController{
    
    @IBOutlet weak var RecipesImage: UIImageView!
    
    @IBOutlet weak var IngredientsDetails: UITableView!
    
    
    @IBAction func DirectionButton(_ sender: Any) {
        guard let linkURL = recipe?.url,
              let recipeURL = URL(string: linkURL),
              UIApplication.shared.canOpenURL(recipeURL)
        else {
            return showAlert(title: "", message: "")
        }
        UIApplication.shared.open(recipeURL, options: [:], completionHandler: nil)
        
    }
    
private var coreDataManager: CoreDataManager?
override func viewDidLoad() {
    super.viewDidLoad()
    if let imageURL = recipe?.image, let url = URL(string: imageURL) {  RecipesImage.load(url: url) }
    guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let coredataStack = appdelegate.coreDataStack
    coreDataManager = CoreDataManager(coreDataStack: coredataStack)
    
    
    
}
    
    @IBOutlet weak var starButton: UIButton!
    @IBAction func favoriteButton(_ sender: Any) {
        
        guard let coreDataManager = coreDataManager else {return}
        guard let recipe = recipe else {return}
        if coreDataManager.isRecipeExist(name: recipe.label){
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            coreDataManager.deleteRecipe(name: recipe.label)
        }else {
            coreDataManager.createRecipe(recipe: recipe)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
      }
        
        
    }
    }
    
   

    
    var recipe: Recipe?

extension DetailsRecipesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = recipe?.ingredientLines [indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 0
    }
}
    




















