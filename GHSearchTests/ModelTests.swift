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
    let decodeSample = try? readFile()

    guard let dataSample = decodeSample else {
      XCTFail("fetch test sample fild Failure")
      return
    }

    let decoder = JSONDecoder()
    let model = try? decoder.decode(SearchUserResult.self, from: dataSample)

    XCTAssertNotNil(model, "decoder model failure")
    XCTAssertEqual(model?.totalCount, 1)
    XCTAssertEqual(model?.items.count, 1)
    XCTAssertEqual(model?.items[0].login, "apple")
    XCTAssertEqual(model?.items[0].avatarUrl, "https://avatars.githubusercontent.com/u/10639145?v=4")
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
