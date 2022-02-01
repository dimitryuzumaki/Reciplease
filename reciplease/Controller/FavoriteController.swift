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
        detailVc.recipe = recipe
    
}
    extension FavoriteController: UITableViewDataSource,UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as!
            RecipeTableViewCell
            cell.recipe = recipes[indexPath.row].recipe
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            recipe = recipes[indexPath.row].recipe
        performSegue(withIdentifier: "FavoriteRecipeDetails", sender: nil)
        }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 190    }
    }
    extension UIImageView {
        func load(url: URL) {
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

}
