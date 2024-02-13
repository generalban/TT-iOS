//
//  SelectIconColorViewController+ColorCollectionViewHeader.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

import SnapKit

extension SelectIconColorViewController {
    final class ColorCollectionViewHeader: BaseCollectionReusableView {
        
        private var title: String = "" {
            didSet {
                update()
            }
        }
        
        // MARK: - View
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 10, weight: .semiBold)
            label.textColor = UIColor(hexCode: "8E8E8E")
            return label
        }()
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(titleLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(18)
                make.leading.equalToSuperview()
            }
        }
        
        override func update() {
            super.update()
            
            titleLabel.text = title
        }
    }
}

extension SelectIconColorViewController.ColorCollectionViewHeader {
    static func makeHeader(to view: UICollectionView,
                           kind: String,
                           indexPath: IndexPath,
                           title: String) -> SelectIconColorViewController.ColorCollectionViewHeader {
        
        guard let header = view.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SelectIconColorViewController
                .ColorCollectionViewHeader.reuseIdentifier,
            for: indexPath) as? SelectIconColorViewController
            .ColorCollectionViewHeader else {
            fatalError("header is not registered to view....")
        }
        header.title = title
        return header
    }
}
