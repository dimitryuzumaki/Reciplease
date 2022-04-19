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
        guard let linkURL = recipeDetails?.url,
              let recipeURL = URL(string: linkURL),
              UIApplication.shared.canOpenURL(recipeURL)
        else {
            return showAlert(title: "", message: "")
        }
        UIApplication.shared.open(recipeURL, options: [:], completionHandler: nil)
        
    }
    
    private var coreDataManager: CoreDataManager?
    var recipeDetails: RecipeDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = RecipesImage.fetchImage(from: recipeDetails?.image) {
            RecipesImage.image = image
        }
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let coreDataManager = coreDataManager else {
            return
        }

        if coreDataManager.isRecipeExist(name: recipeDetails?.name ?? "") {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
            
        
    }
    
    @IBOutlet weak var starButton: UIButton!
    @IBAction func favoriteButton(_ sender: Any) {
        
        guard let coreDataManager = coreDataManager else {return}
        guard let recipe = recipeDetails else {return}
        if coreDataManager.isRecipeExist(name: recipeDetails?.name ?? ""){
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            coreDataManager.deleteRecipe(name: recipeDetails?.name ?? "")
            print ("delete")
        }else {
            coreDataManager.createRecipe(recipe: recipe)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            print ("add")
        }
        
        
    }
}






extension DetailsRecipesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = recipeDetails?.ingredients [indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails?.ingredients.count ?? 0
    }
}





















