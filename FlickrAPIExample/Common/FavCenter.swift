//
//  FavCenter.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

// Note: 簡單點用 UserDefault 來存
//       用 Array 可以連加入順序一起存起來
//       用 Set 對於檢查是否有加入最愛會比較快
//       這邊用 [FlickrAPI.Photo: Date] 保有兩種特性
struct FavCenter {
    private static let key: String = "flickr.fav"
    private(set) static var photoDict: [FlickrAPI.Photo: Date] = {
        // Try to fetch dictionary from local storage
        let data = UserDefaults.standard.data(forKey: key)
        let localDict = data.flatMap { try? JSONDecoder().decode([FlickrAPI.Photo: Date].self, from: $0) }

        // Default empty
        return localDict ?? [:]
    }()

    static func add(_ photo: FlickrAPI.Photo) {
        photoDict[photo] = Date()
        syncDataToLocalStorage()
    }

    static func remove(_ photo: FlickrAPI.Photo) {
        photoDict.removeValue(forKey: photo)
        syncDataToLocalStorage()
    }

    static func isFavorite(_ photo: FlickrAPI.Photo) -> Bool {
        return photoDict[photo] != nil
    }

    // MARK: - Private
    private static func syncDataToLocalStorage() {
        // Save to local
        let data = try? JSONEncoder().encode(photoDict)
        UserDefaults.standard.setValue(data, forKey: key)
    }
}
