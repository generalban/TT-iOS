//
//  HomeViewController+SignInContainerView.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit

extension HomeViewController {
    final class SignInContainerView: BaseView {
        
        // MARK: - View
        
        private let signInContainerView: UIView = UIView()
        
        private let signInStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 20
            return stackView
        }()
        
        let signInButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(named: "Primary color")
            button.setTitle("로그인하러 가기", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .sfProDisplay(size: 15, weight: .semiBold)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            return button
        }()
        
        let registerButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = UIColor(hexCode: "8303FF")
            button.setTitle("회원가입하러 가기", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .sfProDisplay(size: 15, weight: .semiBold)
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            return button
        }()
        
        private let signInIntroduceLabel: UILabel = {
            let label = UILabel()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            
            let baseAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.sfProDisplay(size: 27)]
            
            let attributedText = NSMutableAttributedString(string: "팀을 만들고 티켓으로\n팀원들과 소통하세요.", attributes: baseAttributes)
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            // FIXME: - 한글 지원 폰트 필요
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 1))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 7, length: 2))
            
            label.attributedText = attributedText
            label.textAlignment = .left
            label.numberOfLines = 2
            return label
        }()
        
        private var imageContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "EBF5FF")
            view.clipsToBounds = true
            view.layer.maskedCorners = CACornerMask([.layerMinXMinYCorner,
                                                     .layerMaxXMinYCorner,
                                                     .layerMaxXMaxYCorner,
                                                     .layerMinXMaxYCorner])
            view.layer.cornerRadius = 10
            return view
        }()
        
        private var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "ticket_intro")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(signInStackView)
            addSubview(signInIntroduceLabel)
            addSubview(imageContainerView)
            
            imageContainerView.addSubview(imageView)
            
            [signInButton,
                registerButton
            ].forEach { button in
                signInStackView.addArrangedSubview(button)
            }
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            signInStackView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            signInButton.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
            
            registerButton.snp.makeConstraints { make in
                make.height.equalTo(56)
            }
            
            signInIntroduceLabel.snp.makeConstraints { make in
                make.top.equalTo(signInStackView.snp.bottom).offset(67)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            imageContainerView.snp.makeConstraints { make in
                make.top.equalTo(signInIntroduceLabel.snp.bottom).offset(12)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(180)
                make.bottom.equalToSuperview()
            }
            
            imageView.snp.makeConstraints { make in
                make.height.equalTo(120)
                make.center.equalToSuperview()
            }
        }
    }
}
