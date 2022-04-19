//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 10/11/2021.
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var recipes = [RecipeDetails]()
    var recipe: RecipeDetails?
    var service = EdamamService()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "recipeCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVc = segue.destination as? DetailsRecipesViewController else {return}
        guard let recipe = recipe else {
            return
        }
        
        detailVc.recipeDetails = RecipeDetails(name: recipe.name, image: recipe.image, calories: recipe.calories, totaltimes: recipe.totaltimes, url: recipe.url, ingredients: recipe.ingredients, nextLink: "")
    }
    
}

extension RecipesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as!
        RecipeTableViewCell
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "RecipeDetail", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == recipes.count {
            service.getData(url: recipes[0].nextLink) { result in
                switch result {
                case .success(let recipes) :
                    self.recipes.append(contentsOf: recipes)
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showAlert(title: "", message: "")
                }
            }
        }
    }
}
