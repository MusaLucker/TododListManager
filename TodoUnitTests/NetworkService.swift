//
//  NetworkService.swift
//  TodoUnitTests
//
//  Created by MusaIstema on 21.04.2025.
//

import XCTest
@testable import TodoUIKit
//MARK: - MockHTTPClient
class MockHTTPCLient {
    var inputUrL:String?
    var executeCalled = false
    var result:(Result<[TodoItem],NetworkError>)?
}
extension MockHTTPCLient:HTTPClientProtocol {
    func fetchTodoItems(url:String, completion: @escaping (Result<[TodoUIKit.TodoItem], TodoUIKit.NetworkError>) -> Void) {
        self.executeCalled = true
        self.inputUrL = url
        self.result.map(completion)
    }
    
    
}
struct FakeHTTPService  {
    let httpClient:HTTPClientProtocol
    func search(_ url:String,completion:@escaping (Result<[TodoItem],NetworkError>)->Void) {
        httpClient.fetchTodoItems(url:url) { result in
            completion(self.parse(result))
        }
    }
    
    private func parse(_ result:Result<[TodoItem],NetworkError>) -> Result<[TodoItem],NetworkError> {
        switch result {
        case let.success(todoItems):
            return .success(todoItems)
        case let.failure(error):
            return .failure(error)
        }
    }
}

//MARK: - NetworkService
final class NetworkService: XCTestCase {
    func testExpectationSearch() {
        //GIVEN
        let didRecieveResponse = expectation(description: #function)
        let sut = FakeHTTPService(httpClient:NetworkManager())
        var result: Result<[TodoItem],NetworkError>?
        //WHEN
        sut.search("TODO") {
            result = $0
            didRecieveResponse.fulfill()
        }
        wait(for: [didRecieveResponse], timeout: 5)
        
        //THEN
        switch result {
        case let.success(data):
            print(data)
        case .failure:
            XCTFail("Test failed")
        case .none:
            XCTFail("Test failed")
            
        }
    }
    func testSearch() {
        //GIVEN
        let httpClient = MockHTTPCLient()
        let sut = FakeHTTPService(httpClient: httpClient)
        //WHEN
        sut.search("A") { _ in }
        XCTAssertTrue(httpClient.executeCalled)
    }
}

