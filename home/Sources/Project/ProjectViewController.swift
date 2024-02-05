//
//  ProjectViewController.swift
//  home
//
//  Created by 오연서 on 1/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProjectViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()

    // MARK: - View
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.pushViewController(ProjectEditViewController(), animated: true)
        }))
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.tintColor = UIColor(named: "Cool gray 2")
        return button
    }()
    
    private var scrollview = UIScrollView()
    private var contentView = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket-Taka 팀의 \n프로젝트1 입니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        return label
    }()
    
    private lazy var timelineShortcuts: TimelineShortcuts = {
        TimelineShortcuts()
    }()
    
    lazy var grayline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cool gray 3")
        return view
    }()
    
    private lazy var projectDescription: ProjectDescription = {
        ProjectDescription()
    }()
    
    private lazy var link: Link = {
        Link()
    }()
    
    private lazy var achievement: Achievement = {
        Achievement()
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        [backButton, scrollview].forEach { view in self.view.addSubview(view)}
        scrollview.addSubview(contentView)
        [titleLabel, editButton,timelineShortcuts, grayline, projectDescription, link].forEach { view in contentView.addSubview(view)}
     
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1000)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        timelineShortcuts.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        grayline.snp.makeConstraints { make in
            make.top.equalTo(timelineShortcuts.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        projectDescription.snp.makeConstraints { make in
            make.top.equalTo(grayline.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
        
        link.snp.makeConstraints { make in
            make.top.equalTo(projectDescription.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110)

        }
    }
    
    override func bind() {
        super.bind()
 
        timelineShortcuts.shortcutsIconButton.rx.controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.presentTimelineMainViewController()
            }
            .disposed(by: disposeBag)
    }
    
    private func presentTimelineMainViewController() {
        let viewController = TimelineMainViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
