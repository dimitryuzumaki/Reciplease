// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct EdamamData: Codable {
    let links: WelcomeLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}



// MARK: - Next
struct Next: Codable {
    let href: String
}
// MARK: - Recipe
struct Recipe: Codable {
    var label: String
    let image: String?
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let calories: Double
    let totalTime: Int?
}


// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let next: Next
}

