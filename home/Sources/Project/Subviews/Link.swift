//
//  Link.swift
//  home
//
//  Created by 오연서 on 2/1/24.
//

import UIKit

extension ProjectViewController {
    final class Link: BaseView {
        
        // MARK: - View
        
        private var linkTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "링크"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            return label
        }()
        
        private var githubLink: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "github")
            return view
        }()
        
        private var amazonLink: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: "amazon")
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(linkTitleLabel)
            addSubview(githubLink)
            addSubview(amazonLink)

        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            linkTitleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(30)
            }
            
            githubLink.snp.makeConstraints { make in
                make.top.equalTo(linkTitleLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().inset(30)
                make.size.equalTo(30)
            }
            
            amazonLink.snp.makeConstraints { make in
                make.top.equalTo(linkTitleLabel.snp.bottom).offset(12)
                make.leading.equalTo(githubLink.snp.trailing).offset(25)
                make.size.equalTo(30)
            }
            
        }
    }
}
