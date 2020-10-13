//
//  FavPageViewModel.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

class FavPageViewModel: NSObject, PhotoBrowserViewModelProtocol {
    var title: String { "我的最愛" }
    var cellVMs: [PhotoBrowserCellViewModel] {
        // Sort via added date
        let photosSortedByDate = FavCenter.photoDict.map { (date: $0.value, photo: $0.key) }.sorted {
            (left, right) -> Bool in
            return left.date > right.date
        }

        // Note: 這邊不打算處理從最愛頁更改狀態的情境，直接把按鈕隱藏。
        return photosSortedByDate.map { PhotoBrowserCellViewModel(photo: $0.photo, isFavVisible: false) }
    }
}
