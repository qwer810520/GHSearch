//
//  ModelTests.swift
//  GHSearchTests
//
//  Created by Min on 2021/7/22.
//

import XCTest
@testable import GHSearch

class ModelTests: XCTestCase {

  func test_modelDecode() {
    let jsonFile = try? readFile()
    let headerSample = ["Link": "<https://api.github.com/search/users?q=Apple&per_page=20&page=2>; rel=\"next\", <https://api.github.com/search/users?q=Apple&per_page=20&page=50>; rel=\"last\""]

    guard let dataSample = jsonFile else {
      XCTFail("fetch test sample file Failure")
      return
    }

    let model = SearchUserResponse(header: headerSample, data: dataSample)

    XCTAssertEqual(model.items.count, 1)
    XCTAssertEqual(model.items[0].login, "apple")
    XCTAssertEqual(model.items[0].avatarUrl, "https://avatars.githubusercontent.com/u/10639145?v=4")
    XCTAssertEqual(model.nextPageParmeter, "q=Apple&per_page=20&page=2")
    XCTAssertEqual(model.lastPageParmeter, "q=Apple&per_page=20&page=50")
  }

  // MARK: - Helper

  private func readFile() throws -> Data {
    let bundle = Bundle(for: type(of: self))
    guard let path = bundle.url(forResource: "ModelDecodeSample.json", withExtension: nil) else {
      throw NSError(domain: "fetch Fail", code: 0)
    }
    return try Data(contentsOf: path)
  }
}
