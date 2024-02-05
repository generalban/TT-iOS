//
//  FeedbackRequestPopupViewController+ItemCell.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

extension FeedbackRequestPopupViewController {
    final class ItemCell: BaseCollectionViewCell {
        
        var item: AttachedItem? {
            didSet {
                update()
            }
        }
        
        // MARK: - View
        
        
        private var mainContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "F8F9FC")
            view.layer.cornerRadius = 12
            return view
        }()
        
        var nameLabel: UILabel = {
           let label = UILabel()
            label.font = .sfProDisplay(size: 10)
            label.textColor = UIColor(hexCode: "545454")
            label.textAlignment = .center
            label.lineBreakMode = .byTruncatingMiddle
            return label
        }()
        
        private var removeButton: IconControlComponent = {
            IconControlComponent(imageName: "icon_remove",
                                 bgColor: UIColor(hexCode: "DFE4ED"),
                                 imageSize: 6,
                                 containerSize: 18)
        }()
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            mainContainerView.addSubview(nameLabel)
            mainContainerView.addSubview(removeButton)
            self.addSubview(mainContainerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            mainContainerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(8)
                make.trailing.equalTo(removeButton.snp.leading).offset(-8)
            }
            
            removeButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(8)
            }
        }
        
        override func update() {
            super.update()
            guard let item = item else { return }
            self.nameLabel.text = item.name
        }
    }
}

extension FeedbackRequestPopupViewController.ItemCell {
    static func makeCell(to view: UICollectionView,
                         indexPath: IndexPath,
                         item: AttachedItem) -> FeedbackRequestPopupViewController.ItemCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: FeedbackRequestPopupViewController.ItemCell.reuseIdentifier,
            for: indexPath
        ) as? FeedbackRequestPopupViewController.ItemCell else {
            fatalError("Cell is not registered to view....")
        }
        cell.item = item
        
        return cell
    }
}
