//
//  FlickrAPI.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/12.
//

import Foundation

struct FlickrAPI {

    // MARK: - Core
    private static let host = "www.flickr.com"
    private static let apiKey = "0f270fac4c65c3a1825f34c884142a98"
    private static let format = "json"
    private static let nojsoncallback = "1"

    enum Method: String {
        case search = "flickr.photos.search"
    }

    // Note: 抽 func 方便之後新加 API 的時候可以共用
    static func createURLString(with method: Method, params: [String: String]? = nil) -> String {
        // Create params
        var fullParams: [String: String] = [
            "method": method.rawValue,
            "api_key": apiKey,
            "format": format,
            "nojsoncallback": nojsoncallback
        ]

        if let inputParams = params {
            fullParams = fullParams.merging(inputParams) { (_, last) in last }
        }

        // Create params string
        let paramsStr = fullParams.map { "\($0.key)=\($0.value.urlEncoded ?? "")" }.joined(separator: "&")
        return "https://\(host)/services/rest/?\(paramsStr)"
    }

    static func createURL(with method: Method, params: [String: String]? = nil) -> URL? {
        return URL(string: createURLString(with: method, params: params))
    }
}

// MARK: - Util
private extension String {
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
