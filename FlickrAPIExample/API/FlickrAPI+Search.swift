//
//  FlickrAPI+Search.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

extension FlickrAPI {
    /// Search API
    /// - Parameters:
    ///   - text: Keyword
    ///   - perPage: Max count per search
    ///   - page: Current page index, start from 1
    ///   - completion: Completion hanlder
    static func search(text: String, perPage: String, page: Int = 1, completion: @escaping (PhotosResponse?, URLResponse?, Error?) -> Void) {
        // Check URL
        let params = [
            "text": text,
            "per_page": perPage,
            "page": String(page)
        ]
        guard let url = createURL(with: .search, params: params) else {
            assert(false, "Error: invalid input?")
            return
        }

        // Call API
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            // Decode
            // Note: 這邊為 Example 先不多花時間對 Error 做處理
            DispatchQueue.main.async {
                let result = data.flatMap { try? JSONDecoder().decode(PhotosResponse.self, from: $0) }
                completion(result, response, error)
            }
        }.resume()
    }
}

// MARK: - Codable
extension FlickrAPI {
    struct PhotosResponse: Codable {
        let photos: PhotoResponse
        let stat: String
    }

    struct PhotoResponse: Codable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: String
        let photo: [Photo]
    }

    struct Photo: Codable, Hashable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
    }
}
