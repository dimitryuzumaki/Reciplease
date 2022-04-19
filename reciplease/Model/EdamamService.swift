//
//  EdamamService.swift
//  reciplease
//
//  Created by Dimitry Aumont on 09/10/2021.
//

import Foundation
import Alamofire

enum RecipeError: Error {
    case noData, invalidResponse, undecodableData
}

final class EdamamService {
    
    // MARK: - Properties
    
    private let session: AlamofireSession
    
    // MARK: - Initializer
    
    init(session: AlamofireSession = EdamamSession()) {
        self.session = session
    }
    // MARK: - convertir les données de l'api en objet utilisable, maRecipe permet prend un array de recipeDetails
    private func mapRecipe(with recipes: EdamamData ) -> [RecipeDetails] {
        return recipes.hits.compactMap() {
            RecipeDetails(name: $0.recipe.label, image: $0.recipe.image, calories: "\($0.recipe.calories)", totaltimes: "\($0.recipe.totalTime ?? 0)", url: $0.recipe.url, ingredients: $0.recipe.ingredientLines , nextLink: recipes.links.next.href)
        }
    }
    // MARK: - Management
}
extension EdamamService {
    func getData(ingredients: [String], callback: @escaping (Result<[RecipeDetails], RecipeError>) -> Void) {
        guard let ingredientsEncoded = ingredients.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2/?app_id=bed56e2a&app_key=80136456b7802ea5423ed2e13237c5d0&q=\(ingredientsEncoded)&type=public") else { return }
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(EdamamData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            // MARK: - je crée une propriétés locale et j'appelle ma méthode de conversion en passer l'objet décodé et sa propriétes hit
            let recipes = self.mapRecipe(with: dataDecoded)
            callback(.success(recipes))
        }
        
    }
    func getData(url: String, callback: @escaping (Result<[RecipeDetails], RecipeError>)-> Void) {
        guard let url = URL(string: url) else { return }
        session.request(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(EdamamData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            // MARK: - je crée une propriétés locale et j'appelle ma méthode de conversion en passer l'objet décodé et sa propriétes hit
            let recipes = self.mapRecipe(with: dataDecoded)
            callback(.success(recipes))
    }
}
}
