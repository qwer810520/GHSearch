//
//  APIClient.swift
//  GHSearch
//
//  Created by Min on 2021/7/22.
//

import Foundation
import Alamofire

  // MARK: - Requset failure type

enum HTTPRequestErrorType: LocalizedError {
  case sendRequestFail
  case decodeFailure
  case other(String)
}

  // MARK: - APIClient

class APIClient: NSObject {

  static let shared = APIClient()

  lazy fileprivate var alamoFireManager: Session = {
    let corfiguration = URLSessionConfiguration.default
    corfiguration.timeoutIntervalForRequest = 50
    corfiguration.timeoutIntervalForResource = 50
    return Alamofire.Session(configuration: corfiguration)
  }()

  final func send<T: Decodable>(_ requestType: APIManager, completionHandler: @escaping (Swift.Result<T, Error>) -> Void) {
    alamoFireManager.request(requestType.urlStr, method: Alamofire.HTTPMethod(rawValue: requestType.method.rawValue), parameters: requestType.parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(requestType.headers ?? [:])).responseData { response in

      switch response.result {
        case .success(let data):
          #if DEBUG
            print("reqponseInfo: \(String(data: data, encoding: .utf8) ?? "")")
          #endif
          guard let statusCode = response.response?.statusCode else { return }
          switch statusCode {
            case 200:
              do {
                try completionHandler(.success(data.mapObject(T.self)))
              } catch {
                print(error.localizedDescription)
                completionHandler(.failure(HTTPRequestErrorType.decodeFailure))
              }
            case 304:
              completionHandler(.failure(HTTPRequestErrorType.other("Not Modified")))
            case 422:
              completionHandler(.failure(HTTPRequestErrorType.other("Unprocessable Entity")))
            case 503:
              completionHandler(.failure(HTTPRequestErrorType.other("Service Unavailable")))
            default:
              completionHandler(.failure(HTTPRequestErrorType.other("unknown error")))
          }
        case .failure:
          completionHandler(.failure(HTTPRequestErrorType.sendRequestFail))
      }
    }
  }
}

  // MARK: - request Protocol

typealias JSONDictionary = [String: Any]

protocol TargetType {

  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: JSONDictionary? { get }
  var url: URL? { get }
  var urlStr: String { get }
  var headers: [String: String]? { get }
}

extension TargetType {
  var url: URL? {
    return URL(string: urlStr)
  }

  var urlStr: String {
    return baseURL + path
  }
}

enum HTTPMethod: String {
  case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

  // MARK: - Data Extension

extension Data {
  func mapObject<T: Decodable>(_ type: T.Type) throws -> T {
    return try JSONDecoder().decode(T.self, from: self)
  }
}
