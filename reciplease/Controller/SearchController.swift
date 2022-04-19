//
//  ViewController.swift
//  reciplease
//
//  Created by Dimitry Aumont on 09/10/2021.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var clearListButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private let ingredientManager = IngredientManager()
    private let service = EdamamService()
    private var recipes = [RecipeDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setTargets()
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        ingredientTextField.delegate = self
    }
    
    private func setTargets() {
        addIngredientButton.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)
        searchRecipeButton.addTarget(self, action: #selector(searchRecipe), for: .touchUpInside)
        clearListButton.addTarget(self, action: #selector(clearButtonTap), for: .touchUpInside)
    }
    
    
    @objc private func addIngredient() {
        if let ingredientText = ingredientTextField.text, !ingredientText.isEmpty {
            ingredientManager.add(ingredientText) {
                self.reloadTableView()
                self.ingredientTextField.text = nil
            }
        }
    }
    @objc
    private func dismissKeyboard() {
        ingredientTextField.resignFirstResponder()
    }
    @objc private func clearButtonTap() {
        ingredientManager.ingredientList.removeAll()
        reloadTableView()
        
    }
    
    @objc private func searchRecipe() {
        service.getData(ingredients: ingredientManager.ingredientList) { [weak self] result in DispatchQueue.main.async {
            [self] in switch result {
            case .success(let recipes) :
                self?.ingredientManager.ingredientList = [""]
                self?.recipes = recipes
                self?.performSegue(withIdentifier:"HomeToRecipes" , sender: nil)
            case .failure:
                self?.showAlert(title: "Aucune données", message: "veuillez resaisir vos ingrédients")
            }
        }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recipesController = segue.destination as? RecipesViewController {
            recipesController.recipes = recipes
        }
    }
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientManager.ingredientList.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = .quaternarySystemFill
        cell.textLabel?.text = ingredientManager.ingredientList[indexPath.row]
        return cell
    }
}
extension SearchController: UITableViewDelegate {
    
    
}

extension SearchController: UITextFieldDelegate {
    
}

