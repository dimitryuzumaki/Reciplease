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
    
    // MARK: - Management
    
    func getData(ingredients: [String], callback: @escaping (Result<EdamamData, RecipeError>) -> Void) {
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
            
            callback(.success(dataDecoded))
        }
       
    }
}

