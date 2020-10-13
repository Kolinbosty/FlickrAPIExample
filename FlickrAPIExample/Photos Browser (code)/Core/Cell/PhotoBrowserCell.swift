//
//  PhotoBrowserCell.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/13.
//

import UIKit
import Kingfisher

// TODO: HANDLE SELF SIZING WARNING
class PhotoBrowserCell: UICollectionViewCell {

    private weak var imageView: UIImageView?
    private weak var titleLabel: UILabel?
    private weak var favBtn: UIButton?

    private var viewModel: PhotoBrowserCellViewModel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeUI()
    }

    @objc private func favBtnTapped() {
        viewModel?.favToggle()
        updateFavBtnState()
    }

    /// Update UI state
    /// - Parameter vm: View Model
    func update(with vm: PhotoBrowserCellViewModel) {
        // VM
        viewModel = vm

        // UI
        imageView?.kf.setImage(with: vm.imageURL)
        titleLabel?.text = vm.title
        updateFavBtnState()
    }

    private func updateFavBtnState() {
        guard let vm = viewModel else {
            return
        }
        favBtn?.setTitle(vm.isFav ? "⭐" : "✩" , for: .normal)
        favBtn?.isHidden = !vm.isFavVisible
    }
}

// MARK: - UI
extension PhotoBrowserCell {
    private func initializeUI() {
        // Create UI
        createImageView()
        createTitleLabel()
        createFavBtn()

        // Setup Constraint
        setupConstraints()
    }

    private func createImageView() {
        // Remove old
        self.imageView?.removeFromSuperview()

        // Create & config
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        // Add
        contentView.addSubview(imageView)
        self.imageView = imageView
    }

    private func createTitleLabel() {
        // Remove old
        titleLabel?.removeFromSuperview()

        // Create & config
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1

        // Add
        contentView.addSubview(label)
        titleLabel = label
    }

    private func createFavBtn() {
        // Remove old
        favBtn?.removeFromSuperview()

        // Create & config
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.titleLabel?.font = .systemFont(ofSize: 20.0)
        btn.setTitleColor(.gray, for: .normal)
        btn.addTarget(self, action: #selector(favBtnTapped), for: .touchUpInside)

        // Add
        contentView.addSubview(btn)
        favBtn = btn
    }

    private func setupConstraints() {
        guard let imageView = imageView,
              let titleLabel = titleLabel,
              let favBtn = favBtn else {
            assert(true, "Error: Must create UI first!")
            return
        }

        // Constant
        let itemVSpace: CGFloat = 8.0
        let itemHSpace: CGFloat = 8.0
        let titleHeight: CGFloat = 18.0
        let favBtnHeight: CGFloat = 32.0
        let screenWidth = UIScreen.main.bounds.width
        let imageWidth: CGFloat = floor((screenWidth - 3.0 * itemHSpace) / 2.0)

        // Image
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageWidth)
        ])

        // Title Label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                            constant: itemVSpace),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -itemVSpace),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight)
        ])

        // Favorite Button
        NSLayoutConstraint.activate([
            favBtn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,
                                           constant: -itemVSpace),
            favBtn.rightAnchor.constraint(equalTo: imageView.rightAnchor,
                                          constant: -itemHSpace),
            favBtn.widthAnchor.constraint(equalTo: favBtn.heightAnchor),
            favBtn.heightAnchor.constraint(equalToConstant: favBtnHeight)
        ])
        favBtn.layer.cornerRadius = favBtnHeight / 2.0
    }
}
