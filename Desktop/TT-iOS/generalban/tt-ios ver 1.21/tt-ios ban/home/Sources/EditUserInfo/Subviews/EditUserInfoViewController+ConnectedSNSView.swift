//
//  EditUserInfoViewController+ConnectedSNSView.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

extension EditUserInfoViewController {
    final class ConnectedSNSView: BaseView {
        
        // MARK: - Property
        
        var title: String? {
            didSet { update() }
        }
        
        // MARK: - View
        
        private var mainContainer: UIView = {
            UIView()
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            return stackView
        }()
        
        private var kakaoIcon: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "icon_kakao"))
            imageView.layer.cornerRadius = 24
            return imageView
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(titleLabel)
            mainContainer.addSubview(stackView)

            stackView.addArrangedSubview(kakaoIcon)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(stackView)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(6)
            }
        
            stackView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(9)
                make.leading.equalToSuperview().inset(6)
                make.trailing.lessThanOrEqualToSuperview().inset(6)
            }
            
            kakaoIcon.snp.makeConstraints { make in
                make.width.height.equalTo(48)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            titleLabel.text = title
        }
    }
}
