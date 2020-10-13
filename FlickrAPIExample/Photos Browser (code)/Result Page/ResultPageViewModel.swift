//
//  ResultPageViewModel.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

class ResultPageViewModel: NSObject, PhotoBrowserViewModelProtocol {

    var keyword: String
    var title: String { "搜尋結果: \(keyword)" }
    var cellVMs: [PhotoBrowserCellViewModel]
    private var currentPage: Int
    private var maxPages: Int
    private var perPage: Int

    var isFetching: Bool = false
    var isReachEnd: Bool {
        return currentPage >= maxPages
    }
    var canFetchNextPage: Bool {
        return !isFetching && !isReachEnd
    }

    init(keyword: String, searchResult: FlickrAPI.PhotosResponse) {
        self.keyword = keyword
        self.currentPage = searchResult.photos.page
        self.maxPages = searchResult.photos.pages
        self.perPage = searchResult.photos.perpage
        self.cellVMs = searchResult.photos.photo.map { PhotoBrowserCellViewModel(photo: $0) }
        super.init()
    }

    func fetchNextPageIfAvailable(completion: @escaping (Int, Int) -> Void) {
        guard canFetchNextPage else { return }
        
        // Call API
        let oldCount = cellVMs.count
        isFetching = true
        FlickrAPI.search(text: keyword,
                         perPage: String(perPage),
                         page: currentPage + 1) { [self] (result, response, error) in
            // Note: 不對 Errror 多做處理
            guard let result = result else { return }

            currentPage = result.photos.page
            maxPages = result.photos.pages
            perPage = result.photos.perpage
            cellVMs += result.photos.photo.map { PhotoBrowserCellViewModel(photo: $0) }
            let newCount = cellVMs.count

            // Callback
            completion(oldCount, newCount)
            isFetching = false
        }
    }
}
