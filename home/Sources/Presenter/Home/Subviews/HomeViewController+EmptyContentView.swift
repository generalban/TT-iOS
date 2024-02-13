//
//  HomeViewController+EmptyContentView.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit

extension HomeViewController {
    enum ContentType {
        case project, ticket
        
        var items: (image: UIImage?, title: String, description: String) {
            switch self {
            case .project: (UIImage(named: "empty_project"),
                            "아직 편집한 프로젝트가 없어요.",
                            "팀을 만들고 새로운 프로젝트를 시작해보세요.")
            case .ticket: (UIImage(named: "empty_ticket"),
                           "아직 받은 티켓이 없어요.",
                           "팀원들과 해야 할 일을 티켓으로 주고받아보세요.")
                
            }
        }
    }
    
    final class EmptyContentView: BaseView {
        
        // MARK: - View
        
        private var mainContainer: UIView = {
            let view = UIView()
            return view
        }()
        
        private var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 17, weight: .semiBold)
            label.textColor = UIColor(hexCode: "8E8E8E")
            label.textAlignment = .center
            return label
        }()
        
        private var descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "B8BAC0")
            label.textAlignment = .center
            return label
        }()
        
        convenience init(_ contentType: ContentType) {
            self.init()
            
            let (image, title, description) = contentType.items
            self.imageView.image = image
            self.titleLabel.text = title
            self.descriptionLabel.text =  description
        }
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            [imageView, titleLabel, descriptionLabel].forEach { subview in
                addSubview(subview)
            }
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            self.snp.makeConstraints { make in
                make.bottom.equalTo(descriptionLabel)
            }
            
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(16)
                make.leading.trailing.equalToSuperview()
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(6)
                make.leading.trailing.equalToSuperview()
            }
        }
    }
}
