//
//  HomeViewController+BannerView.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit
import SnapKit

extension HomeViewController {
    final class BannerView: BaseView {
        
        // MARK: - View
        
        private var titleLabel: UILabel = {
            let label = UILabel()
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
        
        func setSignInText() {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            let baseAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "SFProDisplay-Medium", size: 27) ?? UIFont.systemFont(ofSize: 27)]
            let attributedText = NSMutableAttributedString(string: "로그인하고\nTicket-Taka 를\n이용해 보세요.", attributes: baseAttributes)
            
            // 줄 간의 간격 조정
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            // "(이름)"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont(name: "SFProDisplay-Semibold", size: 27) ?? UIFont.systemFont(ofSize: 27), range: NSRange(location: 0, length: 3))
            
            // "Ticket-Taka"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont(name: "SFProDisplay-Semibold", size: 27) ?? UIFont.systemFont(ofSize: 27), range: NSRange(location: 6, length: 12))
            
            titleLabel.attributedText = attributedText
        }
        
        func setUserWelcomText(name: String) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            let baseAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.sfProDisplay(size: 27)]
            let attributedText = NSMutableAttributedString(string: "\(name) 님,\nTicket-Taka 에\n오신 것을 환영합니다.", attributes: baseAttributes)
            
            // 줄 간의 간격 조정
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            // "(이름)"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 5))
            
            // "Ticket-Taka"에 대한 폰트 지정
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: name.count+4, length: 12))
            
            titleLabel.attributedText = attributedText
        }
    }
}
