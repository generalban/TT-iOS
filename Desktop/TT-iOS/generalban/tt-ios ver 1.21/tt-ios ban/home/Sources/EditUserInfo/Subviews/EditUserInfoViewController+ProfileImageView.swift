//
//  EditUserInfoViewController+ProfileImageView.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

extension EditUserInfoViewController {

    final class ProfileImageButton: BaseControl {
        
        // MARK: - View
        
        private var mainContainer = {
            let view = UIImageView()
            return view
        }()
        
        private var profileIconView = {
            IconComponent(imageName:"icon_profile",
                          bgColor: UIColor(hexCode: "0CECEC"),
                          imageSize: 48,
                          containerSize: 88)
        }()
        
        private var cameraIconView = {
            IconComponent(imageName:"icon_photo",
                          bgColor: UIColor(hexCode: "CACFDE"),
                          imageSize: 18,
                          containerSize: 33)
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(profileIconView)
            mainContainer.addSubview(cameraIconView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.width.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.width.equalTo(profileIconView)
                make.top.equalToSuperview()
                make.bottom.equalTo(cameraIconView)
            }
            
            profileIconView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
            }
            
            cameraIconView.snp.makeConstraints { make in
                make.bottom.equalTo(profileIconView).offset(6)
                make.trailing.equalToSuperview()
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
        }
    }
}
