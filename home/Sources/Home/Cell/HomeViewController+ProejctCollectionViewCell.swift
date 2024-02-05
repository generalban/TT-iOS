//
//  HomeViewController+ProjectCollectionViewCell.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit
import SnapKit

extension HomeViewController {

    final class ProjectCollectionViewCell: BaseCollectionViewCell {
        
        // MARK: - Property
        
        private var project: Project! {
            didSet {
                update()
            }
        }
        
        override var isSelected: Bool {
            didSet {
                selected()
            }
        }
        
        // MARK: - View
        
        private var mainContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 10
            return view
        }()
        
        private var projectCardImageView: UIImageView = {
            let imageView = UIImageView()
            return imageView
        }()
        
        private var titleContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        private var teamLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 17)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13)
            label.textColor = UIColor(hexCode: "545454")
            return label
        }()
        
        // MARK: - UI
        
        override func prepare() {
            layer.cornerRadius = 10
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowColor = UIColor(hexCode: "000000", alpha: 0.25).cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            titleContainerView.addSubview(titleLabel)
            mainContainerView.addSubview(projectCardImageView)
            mainContainerView.addSubview(titleContainerView)
            mainContainerView.addSubview(teamLabel)
            
            contentView.addSubview(mainContainerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            mainContainerView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            teamLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.leading.trailing.equalToSuperview().inset(4)
            }
            
            projectCardImageView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            titleContainerView.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.leading.trailing.bottom.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(12)
            }
        }
        
        override func update() {
            super.update()
            
            
            projectCardImageView.image = project.cardImage
            titleLabel.text = project.title
            teamLabel.text = project.team
        }
        
        func selected() {
            
        }
    }
}

extension HomeViewController.ProjectCollectionViewCell {
    static func makeCell(to view: UICollectionView, indexPath: IndexPath,
                         project: Project) -> HomeViewController.ProjectCollectionViewCell {
        guard let cell = view.dequeueReusableCell(
            withReuseIdentifier: HomeViewController.ProjectCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? HomeViewController.ProjectCollectionViewCell else {
            fatalError("Cell is not registered to view....")
        }
        
        
        cell.project = project
        return cell
    }
}
