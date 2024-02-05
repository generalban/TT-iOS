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
    
    enum TeamFilterType: Equatable {
        case all
        case team(name: String)
        
        var description: String {
            switch self {
            case .all: return "전체 팀"
            case let .team(name): return "\(name)"
            }
        }
    }
    
    // MARK: - Property
    
    weak var delegate: TicketTableViewControllerDelegate?
    weak var dataSource: TicketTableViewControllerDataSource?
    
    let disposeBag = DisposeBag()
    
    var ticketStatusFilter: TicketStatus = .done {
        didSet {
            ticketTableView.reloadData()
        }
    }
    
    var teamFilter: TeamFilterType = .all
    
    // MARK: - View
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        return stackView
    }()
    
    private lazy var ticketStatusFilterBox: FilterDropDownView = {
        FilterDropDownView(text: ticketStatusFilter.rawValue.capitalized)
    }()
    
    private lazy var teamFilterBox = {
        FilterDropDownView(text: "전체 팀")
    }()
    
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
        
        stackView.addArrangedSubview(ticketStatusFilterBox)
        stackView.addArrangedSubview(teamFilterBox)
        
        view.addSubview(stackView)
        view.addSubview(ticketTableView)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
        }
        
        ticketTableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
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
        return dataSource?.ticketTableViewController(self)
            .filter {
                (ticketStatusFilter == .all || ticketStatusFilter == $0.status)
                && (teamFilter == .all || teamFilter.description == $0.code) }
            .count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ticket = dataSource?.ticketTableViewController(self).filter({
            (ticketStatusFilter == .all || ticketStatusFilter == $0.status)
            && (teamFilter == .all || teamFilter.description == $0.code)
        })[indexPath.row]
        else {
            return UITableViewCell()
        }
        return TicketTableViewCell
            .makeCell(to: tableView,
                      indexPath: indexPath,
                      ticket: ticket,
                      delegate: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}

extension TicketTableViewController: TicketTableViewCellDelegate {
    func ticketSelected(ticket: Ticket) {
        delegate?.ticketSelected(self, ticket: ticket)
    }
}

protocol TicketTableViewControllerDelegate: AnyObject {
    func ticketSelected(_ tableViewController: TicketTableViewController, ticket: Ticket)
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

protocol TicketTableViewControllerDataSource: AnyObject {
    func ticketTableViewController(_ tableViewController: TicketTableViewController) -> [Ticket]
}
