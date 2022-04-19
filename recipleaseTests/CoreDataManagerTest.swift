//
//  CoreDataManagerTest.swift
//  recipleaseTests
//
//  Created by Dimitry Aumont on 15/03/2022.
//

@testable import reciplease
import XCTest


final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
       
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
        
    }

    // MARK: - Tests
 
    func testAddTeskMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.createRecipe(recipe: RecipeDetails.init(name: "tomatoes", image: "", calories: "", totaltimes: "", url: "", ingredients: [""], nextLink: ""))
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].name! == "tomatoes")
    }

    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.createRecipe(recipe: RecipeDetails.init(name: "tomatoes", image: "", calories: "", totaltimes: "", url: "", ingredients: [""], nextLink: ""))
        coreDataManager.deleteRecipe(name: "tomatoes")
        XCTAssertTrue(coreDataManager.recipes.isEmpty)
    }
    
    func testRecipeIsExist() {
        coreDataManager.createRecipe(recipe: RecipeDetails.init(name: "tomatoes", image: "", calories: "", totaltimes: "", url: "", ingredients: [""], nextLink: ""))
        coreDataManager.isRecipeExist(name: "tomatoes")
        XCTAssertTrue(coreDataManager.recipes.count == 1)
    }
    
}
