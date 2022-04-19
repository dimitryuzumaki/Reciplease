//
//  FakeEdamamSession.swift
//  recipleaseTests
//
//  Created by Dimitry Aumont on 29/03/2022.
//

import Foundation

import Alamofire
@testable import reciplease
struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class FakeEdamamSession: AlamofireSession {

    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    // MARK: - Methods

    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        callback(dataResponse)
    }
}
