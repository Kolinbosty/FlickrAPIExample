//
//  PhotoBrowserCellViewModel.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

class PhotoBrowserCellViewModel: NSObject {
    let photo: FlickrAPI.Photo

    var imageURL: URL? {
        URL(string: "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_z.jpg")
    }

    var title: String {
        photo.title
    }

    var isFav: Bool {
        FavCenter.isFavorite(photo)
    }

    let isFavVisible: Bool

    init(photo: FlickrAPI.Photo,
         isFavVisible: Bool = true) {
        self.photo = photo
        self.isFavVisible = isFavVisible
        super.init()
    }

    func favToggle() {
        if FavCenter.isFavorite(photo) {
            FavCenter.remove(photo)
        } else {
            FavCenter.add(photo)
        }
    }
}
