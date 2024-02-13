//
//  TicketPopupViewController+TagView.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

extension MyPageViewController.TicketPopupViewController {
    final class TagView: BaseControl {
        // MARK: - Property
        
        // MARK: - View
        private var paddedButton: PaddedButton = {
            let label = PaddedButton(text: "",
                                     padding: .init(top: 6,
                                                    left: 9,
                                                    bottom: 6,
                                                    right: 9),
                                     font: .sfProDisplay(size: 10),
                                     cornerRadius: 12)
            return label
        }()
        
        // MARK: - Init
        
        convenience init(icon: UIImage? = nil,
                         iconText: String? = nil,
                         text: String) {
            self.init()
            defer {
                self.paddedButton.iconImage = icon
                self.paddedButton.iconText = iconText
                self.paddedButton.text = text
            }
        }
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(paddedButton)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            self.snp.makeConstraints { make in
                make.bottom.equalTo(paddedButton)
            }
            
            paddedButton.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.trailing.lessThanOrEqualToSuperview()
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            
        }
    }
}
