//
//  AchievementCollectionViewCell.swift
//  home
//
//  Created by 오연서 on 2/5/24.
//

import UIKit

extension  ProjectViewController{
    
    final class AchievementCollectionViewCell: BaseCollectionViewCell {
        
        // MARK: - View
        
        private var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            return view
        }()
        
//        private var achieveProgressBar: CircularProgressBar = {
//            let view = CircularProgressBar()
//            return view
//        }()
 
        private var nameLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13)
            label.text = "허수민"
            return label
        }()

        
        // MARK: - UI

        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(containerView)
//            [achieveProgressBar, nameLabel].forEach { view in
//                containerView.addSubview(view)
//            }

        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            containerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
//            achieveProgressBar.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.centerX.equalToSuperview()
//                make.size.equalTo(50)
//            }
//            
//            nameLabel.snp.makeConstraints { make in
//                make.top.equalTo(achieveProgressBar.snp.bottom).offset(3)
//                make.centerX.equalToSuperview()
//            }
        }
    }
}

extension ProjectViewController.AchievementCollectionViewCell {
    
    static func makeCell(to view: UICollectionView, indexPath: IndexPath) -> ProjectViewController.AchievementCollectionViewCell {
                guard let cell = view.dequeueReusableCell(
                withReuseIdentifier: ProjectViewController.AchievementCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? ProjectViewController.AchievementCollectionViewCell else {
                fatalError("Cell is not registered to view....")
            }

            return cell
    }
}
