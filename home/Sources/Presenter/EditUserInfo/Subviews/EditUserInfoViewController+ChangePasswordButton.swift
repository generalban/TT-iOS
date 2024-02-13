//
//  EditUserInfoViewController+ChangePasswordButton.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

extension EditUserInfoViewController {
    final class ChangePasswordButton: BaseControl {
        // MARK: - Property
        
        var contentText: String? {
            didSet { update() }
        }
        
        // MARK: - View
        
        private var mainContainer: UIView = {
           let view = UIImageView()
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
            view.layer.borderWidth = 1
            return view
        }()
        
        private var contentLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 17)
            return label
        }()

        private var rightArrowImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "icon_right")!)
            imageView.tintColor = .black
            return imageView
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(contentLabel)
            mainContainer.addSubview(rightArrowImageView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(contentLabel.snp.bottom).offset(18)
            }
            
            contentLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(18)
                make.leading.equalToSuperview().inset(18)
                make.trailing.equalTo(rightArrowImageView)
            }
            
            rightArrowImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
                make.width.height.equalTo(24)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            self.contentLabel.text = self.contentText
        }
    }
}
