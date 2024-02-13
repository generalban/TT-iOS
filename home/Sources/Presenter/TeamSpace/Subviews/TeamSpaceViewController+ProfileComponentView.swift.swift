//
//  TeamSpaceViewController+ProfileComponentView.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

extension TeamSpaceViewController {
    final class UserIconView: BaseControl {
        
        // MARK: - Property
        var user: User = User(name: "Name", backgroundColor: .point) {
            didSet {
                update()
            }
        }
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var mainContainer: UIView = {
            UIImageView()
        }()
        
        private var profileIconView: IconComponent = {
            IconComponent(bgColor: .point)
        }()
        
        private var profileTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Name"
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "33315B")
            label.textAlignment = .center
            return label
        }()
        
        // MARK: - Init
        convenience init(user: User) {
            defer {
                self.user = user
            }
            self.init()
        }
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(profileIconView)
            mainContainer.addSubview(profileTitleLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.width.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.trailing.equalTo(profileIconView)
                make.bottom.equalTo(profileTitleLabel)
            }
            
            profileIconView.snp.makeConstraints { make in
                make.top.centerX.equalToSuperview()
            }
            
            profileTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(profileIconView.snp.bottom).offset(8)
                make.leading.trailing.equalToSuperview()
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()

            self.profileIconView.bgColor = user.backgroundColor
            self.profileTitleLabel.text = user.name
        }
    }
}
