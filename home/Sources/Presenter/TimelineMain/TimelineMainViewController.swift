//
//  TimelineMainViewController.swift
//  home
//
//  Created by 오연서 on 2/5/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TimelineMainViewController: BaseViewController {
    
    // MARK: - View
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로젝트 1의\n타임라인 입니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        return label
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private var listLabel: UILabel = {
       let label = UILabel()
        label.text = "목록"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.titleLabel?.font = .sfProDisplay(size: 14, weight: .semiBold)
        button.setTitleColor(UIColor(hexCode: "33315B"), for: .normal)
        button.isHidden = false
        return button
    }()
    
    private lazy var layoutView: UITableView = {
            let view = UITableView(frame: .zero, style: .plain)
            view.register(TimelineTableViewCell.self)
            view.rowHeight = UITableView.automaticDimension
            view.separatorStyle = .none
            return view
        }()
    
    private var addButton: AddTimelineButtonView = {
        AddTimelineButtonView()
    }()
    
    func presentTimelineSubViewController() {
        let viewController = TimelineSubViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Bind

    override func bind() {
        super.bind()
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white

    }
    
    override func initView() {
        super.initView()
        [backButton, alarmButton, titleLabel, dividerView, listLabel,editButton, layoutView,addButton].forEach { view in
            self.view.addSubview(view)
        }
        
        layoutView.dataSource = self
        layoutView.delegate = self
        
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(listLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        layoutView.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
}

extension TimelineMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TimelineTableViewCell.makeCell(to: tableView, indexPath: indexPath)
        cell.titleLabel.text = "타임라인 \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = TimelineSubViewController()
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
}
