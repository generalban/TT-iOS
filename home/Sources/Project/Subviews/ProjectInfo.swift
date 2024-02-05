//
//  ProjectInfo.swift
//  home
//
//  Created by 오연서 on 2/1/24.
//

import UIKit

extension ProjectViewController {
    final class ProjectDescription: BaseView {
        
        // MARK: - View
        
        private var projectDescriptionTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "프로젝트 설명"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            return label
        }()
        
        private var projectDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "우리 티켓으로 소통하자!\n불필요한 소통은 줄이고 프로젝트에 집중할 수\n있는 환경을 만들어주는 서비스 개발"
            label.numberOfLines = 0
            label.font = UIFont(name: "SFProDisplay-Medium", size: 17)
            label.textColor = UIColor(named: "서브 텍스트 2")
            label.backgroundColor = UIColor(named: "Cool gray 4")
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            return label
        }()
        
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            backgroundColor = .white
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(projectDescriptionTitleLabel)
            addSubview(projectDescriptionLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            projectDescriptionTitleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().inset(30)
            }
            
            projectDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(projectDescriptionTitleLabel.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(30)
                make.height.equalTo(100)
            }
        }
    }
}

