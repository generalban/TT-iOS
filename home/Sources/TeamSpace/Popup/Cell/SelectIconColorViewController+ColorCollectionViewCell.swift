//
//  SelectIconColorViewController+ColorCollectionViewCell.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

extension SelectIconColorViewController {
    final class ColorCollectionViewCell: BaseCollectionViewCell {
        
        var bgColor: UIColor? {
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
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            iconContainerView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            self.iconContainerView.isChecked = isChecked
            self.iconContainerView.isDisabled = isDisabled
            self.iconContainerView.bgColor = bgColor
        }
    }
}

extension SelectIconColorViewController.ColorCollectionViewCell {
    static func makeCell(to view: UICollectionView, indexPath: IndexPath, color: UIColor) -> SelectIconColorViewController.ColorCollectionViewCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: SelectIconColorViewController.ColorCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? SelectIconColorViewController.ColorCollectionViewCell else {
            fatalError("Cell is not registered to view....")
        }
        cell.bgColor = color
        
        return cell
    }
}
