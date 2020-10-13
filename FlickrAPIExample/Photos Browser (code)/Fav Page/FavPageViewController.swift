//
//  FavPageViewController.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import UIKit

class FavPageViewController: PhotoBrowserViewController {
    private var favVM: FavPageViewModel

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        let favVM = FavPageViewModel()
        self.favVM = favVM
        super.init(viewModel: favVM)
    }

    override func viewWillAppear(_ animated: Bool) {
        // Reload when tab changed
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
}
