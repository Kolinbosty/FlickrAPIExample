//
//  PhotoBrowserViewController.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import UIKit

// Note: 為範例，這個 VC 用 Code 來實現。
class PhotoBrowserViewController: UIViewController {

    private(set) weak var collectionView: UICollectionView?
    private let viewModel: PhotoBrowserViewModelProtocol

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: PhotoBrowserViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup
        title = viewModel.title
        initializeUI()
        setupCollectionView()
    }
}

// MARK: UICollectionView
// Note: 用 Extension 這樣寫，方便未來整理跟查詢，我也習慣用 Code folding，可以專注在想看的部分。
extension PhotoBrowserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    private var photoCellId: String { "Photo" }

    private func setupCollectionView() {
        collectionView?.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: photoCellId)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellVMs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath)

        // Update cell values
        if let photoCell = cell as? PhotoBrowserCell {
            photoCell.update(with: viewModel.cellVMs[indexPath.item])
        }

        return cell
    }
}

// MARK: - UI
// Note: 這個只是個人習慣，我會把下述的建立成 Code Snippets，方便整理跟用 Code 建立 UI。
//       也比較不會忘記實作特定步驟。
//
//extension <#ClassName#> {
//    private func initializeUI() {
//        // Create UI
//        create<#ViewName#>()
//
//        // Setup Constraint
//        setupConstraints()
//    }
//
//    private func create<#ViewName#>() {
//        // Remove old
//
//        // Create & config
//
//        // Add
//    }
//
//    private func setupConstraints() {
//
//    }
//}
extension PhotoBrowserViewController {
    private func initializeUI() {
        // Create UI
        createCollectionView()

        // Setup Constraint
        setupConstraints()
    }

    private func createCollectionView() {
        // Remove old
        self.collectionView?.removeFromSuperview()

        // Create & config
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self

        // Add
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

    private func setupConstraints() {
        guard let collectionView = self.collectionView else {
            assert(true, "Error: Must create UI first!")
            return
        }

        // CollectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
