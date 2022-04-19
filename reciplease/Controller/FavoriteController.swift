//
//  FavoriteController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 05/01/2022.
//

import UIKit
import CoreData

class FavoriteController: UIViewController{
    
    @IBOutlet weak var favoriteRecipeTableview: UITableView!
    var recipeEntity: RecipeEntity?
    private var coreDataManager: CoreDataManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteRecipeTableview.register(nib, forCellReuseIdentifier: "recipeCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipeTableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVc = segue.destination as? DetailsRecipesViewController else {return}
        guard let recipeEntity = recipeEntity else {
            return
        }
        
        detailVc.recipeDetails = RecipeDetails(name: String (recipeEntity.name ?? ""), image: recipeEntity.image, calories: String (recipeEntity.calories ?? ""), totaltimes: String (recipeEntity.totalTime ?? "") , url: String (recipeEntity.url ?? ""), ingredients: [String] (recipeEntity.ingredients ?? [""]), nextLink: "")
        
    }
    
}
extension FavoriteController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as!
        RecipeTableViewCell
        guard let coreDataManager = coreDataManager else{return UITableViewCell()}
        let recipe = coreDataManager.recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeEntity = coreDataManager?.recipes[indexPath.row]
        performSegue(withIdentifier: "FavoriteRecipeDetails", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            coreDataManager?.deleteRecipe(name: coreDataManager?.recipes[indexPath.row].name ?? "")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }
}


