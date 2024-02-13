//
//  SignInViewController+MaintainButton.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

extension SignInViewController {
    final class MaintainButton: BaseControl {
        
        // MARK: - Property
        override var isSelected: Bool {
            didSet {
                update()
            }
        }
        
        private var disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var containerView: UIView = {
            UIImageView()
        }()
        
        private var iconContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "B8BAC0")
            view.layer.cornerRadius = 12
            return view
        }()
        
        private var iconView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "icon_check")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private lazy var textLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13)
            label.text = "로그인 상태 유지하기"
            label.textColor = UIColor(hexCode: "545454")
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(containerView)
            
            iconContainerView.addSubview(iconView)
            containerView.addSubview(iconContainerView)
            containerView.addSubview(textLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.width.equalTo(containerView)
            }
            
            containerView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.bottom.equalTo(iconContainerView)
                make.trailing.equalTo(textLabel)
            }
            
            iconContainerView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.size.equalTo(24)
            }
            
            iconView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(12)
                make.height.equalTo(8)
            }
            
            textLabel.snp.makeConstraints { make in
                make.centerY.equalTo(iconContainerView)
                make.leading.equalTo(iconContainerView.snp.trailing).offset(6)
            }
        }
        
        // MARK: - Bind
        
        override func bindEvents() {
            self.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.isSelected.toggle()
            }
                .disposed(by: disposeBag)
        }
        
        override func update() {
            super.update()
            
            iconContainerView.backgroundColor = isSelected ? UIColor(hexCode: "8303FF") : UIColor(hexCode: "B8BAC0")
            
        }
    }
}
