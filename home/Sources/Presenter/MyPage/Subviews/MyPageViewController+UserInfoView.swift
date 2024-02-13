//
//  MyPageViewController+UserInfoView.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

extension MyPageViewController {
    final class UserInfoView: BaseView {   
        
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private lazy var iconView: IconComponent = {
           IconComponent(bgColor: UIColor(hexCode: "0CECEC"))
        }()
        
        private lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.text = "허수민 님"
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        var editUserInfoButton: PaddedButton = {
            let button = PaddedButton(text: "내 정보 수정", padding: .init(top: 8, left: 8, bottom: 8, right: 8))
            return button
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(iconView)
            addSubview(nameLabel)
            addSubview(editUserInfoButton)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            self.snp.makeConstraints { make in
                make.bottom.equalTo(iconView).offset(20)
            }
            
            iconView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.leading.equalToSuperview()
            }
            
            nameLabel.snp.makeConstraints { make in
                make.centerY.equalTo(iconView)
                make.leading.equalTo(iconView.snp.trailing).offset(10)
            }
            
            editUserInfoButton.snp.makeConstraints { make in
                make.centerY.equalTo(iconView)
                make.trailing.equalToSuperview()
            }
        }
        
        func updateHeight() {
            self.snp.makeConstraints { make in
                make.bottom.equalTo(iconView).offset(20)
            }
        }
    }
}
