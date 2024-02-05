//
//  UIFont+.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

enum SFProDisplayFontWeight {
    case medium
    case semiBold
}

extension UIFont {
    static func sfProDisplay(size: CGFloat,
                             weight: SFProDisplayFontWeight = .medium) -> UIFont {
        switch weight {
        case .medium:
            return UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBold:
            return UIFont(name: "SFProDisplay-SemiBold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        }
    }
}
