//
//  Achievement.swift
//  home
//
//  Created by 오연서 on 2/1/24.
//

import UIKit

extension ProjectViewController {
    final class Achievement: BaseView {
        
        // MARK: - View
        
        private var achievementLabel: UILabel = {
            let label = UILabel()
            label.text = "팀원별 성취도"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            backgroundColor = .white
        }
        
        override func configureSubviews() {
            super.configureSubviews()
    
            addSubview(achievementLabel)
            
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            achievementLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(30)
            }
        }
    }
}

