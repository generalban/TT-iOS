//
//  HomeViewController+UserContainerViewController.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit
import SnapKit

extension HomeViewController {
    final class UserContainerViewController: BaseViewController {
        
        var datasource: UserContainerViewControllerDataSource? = nil
        
        // MARK: - View
        
        private var recentProjectContainer: UIView = UIView()
        
        private var recentProjectLabel: UILabel = {
            let label = UILabel()
            label.text = "최근 편집한 프로젝트 바로가기"
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var recentProjectEmptyView: EmptyContentView = {
            EmptyContentView(.project)
        }()
        
        private lazy var projectCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = .init(width: 156, height: 183)
            layout.minimumInteritemSpacing = 18
            layout.minimumLineSpacing = 18
            layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(ProjectCollectionViewCell.self)
            collectionView.clipsToBounds = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .white
            return collectionView
        }()
        
        private var deadlineImminentTicketContainer: UIView = UIView()
        
        private var deadlineImminentTicketLabel: UILabel = {
            let label = UILabel()
            label.text = "마감 임박 티켓"
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private lazy var ticketTableView: UITableView = {
            let tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = .clear
            tableView.rowHeight = 154
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            tableView.register(HomeViewController.TicketTableViewCell.self)
            tableView.backgroundColor = UIColor(hexCode: "F8F9FC")
            tableView.sectionHeaderHeight = 2
            tableView.layer.cornerRadius = 20
            tableView.clipsToBounds = true
            tableView.layer.maskedCorners = CACornerMask([.layerMinXMinYCorner,
                                                          .layerMaxXMinYCorner])
            return tableView
        }()
        
        private var deadlineImminentTicketEmptyView: EmptyContentView = {
            EmptyContentView(.ticket)
        }()
        
        // MARK: - UI
        
        override func setUp() {
            super.setUp()
        }
        
        override func initView() {
            super.initView()
            
            view.addSubview(recentProjectContainer)
            view.addSubview(deadlineImminentTicketContainer)
            
            [recentProjectLabel,
             recentProjectEmptyView,
             projectCollectionView].forEach { subview in
                recentProjectContainer.addSubview(subview)
            }
            
            [deadlineImminentTicketLabel,
             deadlineImminentTicketEmptyView,
             ticketTableView].forEach { subview in
                deadlineImminentTicketContainer.addSubview(subview)
            }
        }
        
        override func initConstraint() {
            super.initConstraint()
            
            recentProjectContainer.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(34)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(projectCollectionView.snp.bottom)
            }
            
            recentProjectLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            recentProjectEmptyView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.center.equalTo(projectCollectionView)
            }
            
            projectCollectionView.snp.makeConstraints { make in
                make.top.equalTo(recentProjectLabel.snp.bottom).offset(15)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(190)
            }
            
            deadlineImminentTicketContainer.snp.makeConstraints { make in
                make.top.equalTo(recentProjectContainer.snp.bottom).offset(36)
                make.leading.trailing.equalToSuperview()
            }
            
            deadlineImminentTicketLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            deadlineImminentTicketEmptyView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(deadlineImminentTicketLabel.snp.bottom).offset(15)
            }
            
            ticketTableView.snp.makeConstraints { make in
                make.top.equalTo(deadlineImminentTicketLabel.snp.bottom).offset(15)
                make.leading.trailing.equalTo(deadlineImminentTicketContainer)
                make.bottom.equalToSuperview()
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            let height = ticketTableView.contentSize.height + 60
            ticketTableView.snp.removeConstraints()
            ticketTableView.snp.makeConstraints { make in
                make.top.equalTo(deadlineImminentTicketLabel.snp.bottom).offset(15)
                make.height.equalTo(height)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            self.view.snp.makeConstraints { make in
                make.bottom.equalTo(deadlineImminentTicketContainer)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension HomeViewController.UserContainerViewController: UICollectionViewDelegate,
                                                          UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = datasource?.projectCollectionView() ?? 0
        projectCollectionView.backgroundColor = count != 0 ? .white : .clear
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let project = datasource?.projectCollectionView(row: indexPath.row) else {
            return UICollectionViewCell()
        }
        return HomeViewController.ProjectCollectionViewCell
            .makeCell(to: collectionView,
                      indexPath: indexPath,
                      project: project)
    }
}

extension HomeViewController.UserContainerViewController: UITableViewDelegate,
                                                          UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = datasource?.ticketTableView() ?? 0
        ticketTableView.backgroundColor = count != 0 ? UIColor(hexCode: "F8F9FC") : .clear
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ticket = datasource?.ticketTableView(row: indexPath.row) else {
            return UITableViewCell()
        }
        return HomeViewController.TicketTableViewCell
            .makeCell(to: tableView,
                      indexPath: indexPath,
                      ticket: ticket)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
}

protocol UserContainerViewControllerDataSource {
    
    func projectCollectionView() -> Int
    func projectCollectionView(row: Int) -> Project
    
    func ticketTableView() -> Int
    func ticketTableView(row: Int) -> Ticket
}
