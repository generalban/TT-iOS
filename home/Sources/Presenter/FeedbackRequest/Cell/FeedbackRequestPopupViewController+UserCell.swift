//
//  FeedbackRequestPopupViewController+UserCell.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

extension FeedbackRequestPopupViewController {
    final class UserCell: BaseCollectionViewCell {
        
        var user: User? {
            didSet {
                update()
            }
        }
        
        var isChecked: Bool = false {
            didSet {
                update()
            }
        }
        
         var isDisabled: Bool = false {
            didSet {
                update()
            }
        }
        
        var nameLabel: UILabel = {
           let label = UILabel()
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "33315B")
            label.textAlignment = .center
            return label
        }()
        
        // MARK: - View
        
        private var iconContainerView: IconComponent = {
            IconComponent(imageName: "icon_my",
                          bgColor: .point,
                          imageSize: 24,
                          containerSize: 44)
        }()
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            contentView.addSubview(iconContainerView)
            contentView.addSubview(nameLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            iconContainerView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
        }
        
        override func update() {
            super.update()
            
            self.iconContainerView.isChecked = isChecked
            self.iconContainerView.isDisabled = isDisabled
            self.iconContainerView.bgColor = user?.backgroundColor
            self.nameLabel.text = user?.name
        }
    }
}

extension FeedbackRequestPopupViewController.UserCell {
    static func makeCell(to view: UICollectionView,
                         indexPath: IndexPath,
                         user: User) -> FeedbackRequestPopupViewController.UserCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: FeedbackRequestPopupViewController.UserCell.reuseIdentifier,
            for: indexPath
        ) as? FeedbackRequestPopupViewController.UserCell else {
            fatalError("Cell is not registered to view....")
        }
        cell.user = user
        
        return cell
    }
}
