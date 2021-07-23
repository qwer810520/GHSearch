//
//  SearchUserViewModel.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation

typealias Observer<T> = (T) -> Void

final class SearchUserViewModel: NSObject {

  private var allUsers: [User] = [] {
    didSet { userList?(allUsers) }
  }

  var userList: Observer<[User]>?
  var requestError: Observer<String>?

  private var currentSearchInfo = SearchParametersInfo(keyword: "")

  func searchUser(with keyword: String) {
    guard !keyword.isEmpty else { return }

    currentSearchInfo = SearchParametersInfo(keyword: keyword)

    APIClient.shared.send(.searchUser(currentSearchInfo.firstPageParameter)) { [weak self] (result: Result<SearchUserResponse, Error>) in
      switch result {
        case let .success(responseInfo):
          self?.allUsers = responseInfo.items
          self?.currentSearchInfo.updatePageParmeter(with: responseInfo)
        case let .failure(error):
          self?.requestError?("fetch failure, error is \(error.localizedDescription)")
      }
    }
  }

  func fetchNextPage() {
    guard !currentSearchInfo.isLastPage else { return }

    APIClient.shared.send(.searchUser(currentSearchInfo.nextPageParameter)) { [weak self] (result: Result<SearchUserResponse, Error>) in
      switch result {
        case let .success(responseInfo):
          self?.allUsers.append(contentsOf: responseInfo.items)
          self?.currentSearchInfo.updatePageParmeter(with: responseInfo)
        case let .failure(error):
          self?.requestError?("fetch failure, error is \(error.localizedDescription)")
      }
    }
  }
}
