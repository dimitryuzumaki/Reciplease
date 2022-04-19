//
//  EdamamServiceTest.swift
//  recipleaseTests
//
//  Created by Dimitry Aumont on 25/03/2022.
//

import XCTest
@testable import reciplease

class RequestServiceTests: XCTestCase {
    
    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredients: []) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let edamamService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getData(ingredients: []){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredients: []) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredients: ["salad"]) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }
            XCTAssertTrue(data[0].name == "Roasted Tomatoes Recipe")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testMoreData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(url: "https://www.apple.com") { result in
            guard case .success(let data) = result else {
                XCTFail("Test MoreData method with correct data failed.")
                return
            }
            XCTAssertTrue(data[0].nextLink == "https://api.edamam.com/api/recipes/v2/?q=tomatoes&app_key=80136456b7802ea5423ed2e13237c5d0&_cont=CHcVQBtNNQphDmgVQntAEX4BYlBtAwUFRGFGAGEUa1xzAgEBUXlSADEQa1x3DQECSzMVBWMQYlF2UQABFTMUBDYVMgd1UlUVLnlSVSBMPkd5BgMbUSYRVTdgMgksRlpSAAcRXTVGcV84SU4%3D&type=public&app_id=bed56e2a")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testMoreData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(url: "https://www.apple.com") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test MoreData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testMoreData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(url: "https://www.apple.com") { result in
            guard case .failure(let error) = result else {
                XCTFail("Test MoreData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testMoreData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeEdamamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let edamamService = EdamamService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getData(url: "https://www.apple.com"){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test MoreData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}





