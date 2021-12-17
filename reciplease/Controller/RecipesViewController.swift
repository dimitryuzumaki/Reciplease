//
//  RecipesViewController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 10/11/2021.
//

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var recipes = [Hit]()
    var recipe: Recipe?
    override func viewDidLoad() {
        super.viewDidLoad()

     let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "recipeCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVc = segue.destination as? DetailsRecipesViewController else {return}
        detailVc.recipe = recipe
    }
}
extension RecipesViewController: UITableViewDataSource,UITableViewDelegate {
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
    performSegue(withIdentifier: "RecipeDetail", sender: nil)
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
