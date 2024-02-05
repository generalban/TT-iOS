//
//  AlertViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class AlertViewController: BaseViewController {
    
    // MARK: - Test Data
    
    private var alerts: [Alert] = Alert.dummy
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    
    private var bannerView: UIView = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = .sfProDisplay(size: 27, weight: .semiBold)
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        return button
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private lazy var alertTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AlertViewController.AlertTableViewCell.self)
        tableView.rowHeight = 106
        tableView.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        
        bannerView.addSubview(backButton)
        bannerView.addSubview(titleLabel)
        bannerView.addSubview(dividerView)
        view.addSubview(alertTableView)
        view.addSubview(bannerView)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        bannerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(dividerView)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
        }
        
        alertTableView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Bind
    
    override func bind() {
        super.bind()
        backButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension AlertViewController: UITableViewDelegate,
                               UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        AlertTableViewCell.makeCell(to: tableView, 
                                    indexPath: indexPath,
                                    alert: alerts[indexPath.row],
                                    delegate: self)
    }
}

extension AlertViewController: AlertTableViewCellDelegate {
    func alertTableViewCell(type: AlertTableViewCellActionType, alert: Alert) {
        switch alert.type {
        case .feedback:
            presentFeedbackPopupViewController(alert: alert)
        case .invite:
            switch type {
            default: break
            }
        case .resend:
            ResendPopupViewController.present(alert: alert)
            // ResendRequestPopupViewController.present(alert: alert)
        case .sendTicket:
            // FIXME: - 티켓 전송
            break
        }
    }
    
    
    func presentFeedbackPopupViewController(alert: Alert) {
        FeedbackPopupViewController.present(alert: alert)
    }
    
    func presentResendPopupViewController(alert: Alert) {
        ResendRequestPopupViewController.present(alert: alert)
    }
}
