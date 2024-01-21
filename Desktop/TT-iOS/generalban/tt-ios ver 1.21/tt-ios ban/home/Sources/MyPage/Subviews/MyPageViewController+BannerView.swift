//
//  MyPageViewController+BannerView.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

extension MyPageViewController {
    final class BannerView: BaseView {
        
        // MARK: - View
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            
            let baseAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.sfProDisplay(size: 27)]
            
            let attributedText = NSMutableAttributedString(string: "허수민 님의\n마이페이지입니다.", attributes: baseAttributes)
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            // FIXME: - 한글 지원 폰트 필요
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 3))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 6, length: 5))
            
            label.attributedText = attributedText
            label.textAlignment = .left
            label.numberOfLines = 3
            
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(titleLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            self.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel).offset(24)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(46)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
        
        func updateHeight(){
            self.snp.makeConstraints { make in
                make.bottom.equalTo(titleLabel).offset(24)
            }
        }
    }
}
