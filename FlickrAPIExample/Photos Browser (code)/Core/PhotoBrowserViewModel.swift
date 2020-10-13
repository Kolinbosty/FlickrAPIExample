//
//  PhotoBrowserViewModel.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import Foundation

protocol PhotoBrowserViewModelProtocol {
    var title: String { get }
    var cellVMs: [PhotoBrowserCellViewModel] { get }
}
