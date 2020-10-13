//
//  ResultPageViewController.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import UIKit

class ResultPageViewController: PhotoBrowserViewController {
    private var resultVM: ResultPageViewModel

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(resultVM: ResultPageViewModel) {
        self.resultVM = resultVM
        super.init(viewModel: resultVM)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleMaxY = scrollView.contentOffset.y + scrollView.bounds.height
        let contentMaxY = scrollView.contentSize.height
        let reachBottom = visibleMaxY >= contentMaxY

        // Load more if available
        if reachBottom {
            resultVM.fetchNextPageIfAvailable { [self] (oldCount, newCount) in
                // Insert new photo
                let newIndexPaths = (oldCount..<newCount).map { IndexPath(item: $0, section: 0) }
                self.collectionView?.insertItems(at: newIndexPaths)
            }
        }
    }
}
