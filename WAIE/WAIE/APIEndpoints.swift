//
//  APIEndpoints.swift
//  WAIE
//
//  Created by Anshu Kumar Ray on 09/02/23.
//

import Foundation
import Network

public typealias Headers = [String: String]

enum APIEndpoints {
    case getPlanetary
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPlanetary:
            return .GET
        }
    }
    
    func createRequest(key: String, environment: Environment = .staging) -> NetworkRequest {
        let headers: Headers = [:]
        return NetworkRequest(key: key,
                              url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
    
    var requestBody: Encodable? {
        switch self {
        case .getPlanetary:
            return nil
        }
    }
    
    func getURL(from environment: Environment) -> String {
        let baseUrl = environment.serviceBaseUrl
        switch self {
        case .getPlanetary:
            return "\(baseUrl)/planetary/apod"
        }
    }
}

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    var serviceBaseUrl: String {
        switch self {
        case .development, .staging, .production:
            return "https://api.nasa.gov"
        }
    }
}
