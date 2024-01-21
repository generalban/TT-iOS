//
//  UICollectionView+Extension.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

extension UICollectionView {
    func register(_ reusableViewType: BaseCollectionReusableView.Type,
                  _ supplementaryViewOfKind: String =  UICollectionView.elementKindSectionHeader) {
        register(reusableViewType,
                 forSupplementaryViewOfKind: supplementaryViewOfKind,
                 withReuseIdentifier: reusableViewType.reuseIdentifier)
    }
    
    func register(_ cellType: BaseCollectionViewCell.Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }
}
