//
//  TicketTableViewController.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

import SnapKit
import RxSwift

final class TicketTableViewController: BaseViewController {
    
    // MARK: - Property
    
    weak var delegate: TicketTableViewControllerDelegate?
    weak var dataSource: TicketTableViewControllerDataSource?
    
    let disposeBag = DisposeBag()
    
    // MARK: - View
    
    private var ticketTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 154
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        ticketTableView.register(TicketTableViewCell.self)
        ticketTableView.delegate = self
        ticketTableView.dataSource = self
    }
    
    override func initView() {
        super.initView()
        
        view.addSubview(ticketTableView)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        ticketTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
    }
    
    func reloadData(){
        ticketTableView.reloadData()
    }
}

extension TicketTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.tableViewController(self, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ticket = dataSource?.tableViewController(self,
                                                           cellDataForRowAt: indexPath) else {
            return UITableViewCell()
        }
        return TicketTableViewCell
            .makeCell(to: tableView, indexPath: indexPath, ticket: ticket)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
    
}

protocol TicketTableViewControllerDelegate: AnyObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

protocol TicketTableViewControllerDataSource: AnyObject {
    func tableViewController(_ tableViewController: TicketTableViewController,
                             numberOfRowsInSection section: Int) -> Int
    
    func tableViewController(_ tableViewController: TicketTableViewController,
                             cellDataForRowAt indexPath: IndexPath) -> Ticket?
    
}
