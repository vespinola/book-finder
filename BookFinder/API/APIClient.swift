//
//  HTTPClient.swift
//  BookSearcher
//
//  Created by user on 6/21/20.
//  Copyright © 2020 vel. All rights reserved.
//

import Foundation
import Alamofire
import Sniffer

typealias failureCallback = (APIError) -> Void
typealias GenericDictionary = [String: Any]

enum Encoding {
    case `default`
    case json
    case query
    
    var alamofire: ParameterEncoding {
        switch self {
        case .default:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        case .query:
            return URLEncoding.queryString
        }
    }
}

struct ResponseType {
    static let success = "success"
    static let error = "error"
}

class APIClient {
    class func request<T: Codable>(
        verb: HTTPMethod = .get,
        endpoint: String,
        parameters: [String: Any] = [:],
        headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ],
        encoding: Encoding = .default,
        success: @escaping (T) -> Swift.Void,
        failure: ((APIError) -> Swift.Void)? = nil
        ) {
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            failure?(APIError(type: .connection))
            return
        }
        
        BaseSessionManager.shared
            .request(endpoint,
                     method: verb,
                     parameters: parameters,
                     encoding: encoding.alamofire,
                     headers: headers)
            .validate()
            .response(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    guard response.error == nil else {
                        //We got a timeout
                        if response.error?._code == NSURLErrorTimedOut {
                            failure?(APIError(type: .timeout))
                        } else {
                            failure?(APIError(type: .generic))
                        }
                        return
                    }
                    
                    guard let data = data else {
                        failure?(APIError())
                        return
                    }
                    
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        success(decoded)
                    } catch (let error) {
                        let apiError = APIError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 404:
                        let apiError = APIError(type: .notFound)
                        failure?(apiError)
                    default:
                        let apiError = APIError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                }
            })
    }
}

class BaseSessionManager: Session {
    static let shared: BaseSessionManager = {
        let configuration = URLSessionConfiguration.default
        Sniffer.enable(in: configuration)
        configuration.timeoutIntervalForRequest = 30
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let manager = BaseSessionManager(configuration: configuration)
        return manager
    }()
}
