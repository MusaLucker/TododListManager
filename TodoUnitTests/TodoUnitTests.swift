//
//  TodoUnitTests.swift
//  TodoUnitTests
//
//  Created by MusaIstema on 21.04.2025.
//

import XCTest
@testable import TodoUIKit

final class TodoUnitTests: XCTestCase {
    var sut:NetworkManager!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager()
    }
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    func testPerfomance() {
        self.measure {
            DataBaseManager.shared.createTodoItem(title: "titleOne", descript: "descriptionOne", completed: false)
        }
    }
    
    
}
