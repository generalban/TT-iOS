//
//  SignInViewController+UnderlineButton.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

extension SignInViewController {
    final class UnderlineButton: BaseControl {
        
        // MARK: - Property
        
        var text: String = "" {
            didSet {
                update()
            }
        }
        
        // MARK: - View
        
        private var containerView: UIView = {
            UIImageView()
        }()
        
        private var textLabel: UILabel = {
            let label = UILabel()
            label.textColor =  UIColor(hexCode: "545454")
            label.font = .sfProDisplay(size: 13)
            return label
        }()
        
        private var underline: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "545454")
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(containerView)
            
            containerView.addSubview(textLabel)
            containerView.addSubview(underline)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.width.equalTo(containerView)
            }
            
            containerView.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.bottom.trailing.equalTo(textLabel)
            }
            
            textLabel.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
            }
            
            underline.snp.makeConstraints { make in
                make.leading.trailing.equalTo(textLabel)
                make.bottom.equalTo(textLabel)
                make.height.equalTo(1)
            }
        }
        
        override func update() {
            super.update()
            textLabel.text = text
        }
    }
}
