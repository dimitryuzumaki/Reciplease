//
//  FavoriteController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 05/01/2022.
//

import UIKit
import CoreData

class FavoriteController: UIViewController{
    
    @IBOutlet weak var FavoriteRecipes: UITableView!
    var recipeEntity: RecipeEntity?
    private var coreDataManager: CoreDataManager?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        FavoriteRecipes.register(nib, forCellReuseIdentifier: "recipeCell")
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let detailVc = segue.destination as? DetailsRecipesViewController else {return}
         guard let recipeEntity = recipeEntity else {
             return
         }
         

        
   }
    
}
extension FavoriteController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as!
        RecipeTableViewCell
        cell.recipeEntity = coreDataManager?.recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeEntity = coreDataManager?.recipes[indexPath.row]
        performSegue(withIdentifier: "FavoriteRecipeDetails", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190    }
}
extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
