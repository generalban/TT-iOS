//
//  TicketTableViewCell.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

extension TicketTableViewController {
    final class TicketTableViewCell: BaseTableViewCell {
        
        // MARK: - Property
        
        private var ticket: Ticket! {
            didSet {
                update()
            }
        }
        
        // MARK: - View
        
        private var mainContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.clipsToBounds = true
            view.layer.cornerRadius = 5
            return view
        }()
        
        private var ticketContentContainer: UIView = {
            UIView()
        }()
        
        private var ticketColorView: UIView = {
            let view = UIView()
            view.backgroundColor = .point
            return view
        }()
        
        private var nameLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 20, weight: .semiBold)
            label.textColor = .black
            return label
        }()
        
        private var descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var statusContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "DFE4ED")
            view.layer.cornerRadius = 5
            return view
        }()
        
        private var statusLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        private var contentMask: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "ticket_content_frame"))
            imageView.contentMode = .scaleToFill
            return imageView
        }()
        
        private var ticketInfoContainer: UIView = {
            UIView()
        }()
        
        private var dateLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 12, weight: .semiBold)
            label.textColor = UIColor(hexCode: "545454")
            label.textAlignment = .center
            return label
        }()
        
        private var moveIcon: IconComponent = {
            IconComponent(imageName: "icon_move",
                          bgColor: .clear,
                          imageSize: 30,
                          containerSize: 30)
        }()
        
        private var infoMask: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "ticket_info_frame"))
            return imageView
        }()
        
        
        // MARK: - UI
        
        override func prepare() {
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            statusContainerView.addSubview(statusLabel)
            
            let ticketContentContainerSubviews: [UIView] = [ticketColorView,
                                                            nameLabel,
                                                            descriptionLabel,
                                                            statusContainerView,
                                                            contentMask
            ]
            
            ticketContentContainerSubviews.forEach { subview in
                ticketContentContainer.addSubview(subview)
            }
            
            let ticketInfoContainerSubviews: [UIView] = [
                dateLabel,
                moveIcon,
                infoMask
            ]
            
            ticketInfoContainerSubviews.forEach { subview in
                ticketInfoContainer.addSubview(subview)
            }
            
            mainContainerView.addSubview(ticketContentContainer)
            mainContainerView.addSubview(ticketInfoContainer)
            
            contentView.addSubview(mainContainerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            
            mainContainerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.leading.trailing.equalToSuperview().inset(20)
            }
            
            ticketContentContainer.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.trailing.equalTo(ticketInfoContainer.snp.leading)
            }
            ticketInfoContainer.snp.makeConstraints { make in
                make.top.trailing.bottom.equalToSuperview()
                make.width.equalTo(50)
            }
            
            contentMask.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            ticketColorView.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.width.equalTo(20)
            }
            
            nameLabel.snp.makeConstraints { make in
                make.leading.equalTo(ticketColorView.snp.trailing).inset(-10)
                make.trailing.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.leading.equalTo(ticketColorView.snp.trailing).inset(-10)
                make.top.equalTo(nameLabel.snp.bottom).offset(14)
            }
            
            statusContainerView.snp.makeConstraints { make in
                make.leading.equalTo(ticketColorView.snp.trailing).inset(-10)
                make.top.equalTo(10)
                make.width.equalTo(84)
                make.height.equalTo(24)
            }
            
            statusLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            }
            
            dateLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(10)
                make.leading.trailing.equalToSuperview()
            }
            
            moveIcon.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(10)
                make.centerX.equalToSuperview()
            }
            
            infoMask.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
        }
        
        override func update() {
            super.update()
            
            switch ticket.status {
            case .done:
                ticketInfoContainer.isHidden = true
            case .inProgress:
                ticketInfoContainer.isHidden = false
            case .toDo:
                ticketInfoContainer.isHidden = false
            }
            
            ticketColorView.backgroundColor = ticket.color
            nameLabel.text = ticket.name
            descriptionLabel.text = ticket.description
            statusLabel.text = ticket.status.rawValue
            
            dateLabel.text = ticket.date
            
            moveIcon.isHidden = !ticket.move
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            
        }
        
        override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            
        }
    }
}

extension TicketTableViewController.TicketTableViewCell {
    static func makeCell(to view: UITableView, indexPath: IndexPath, ticket: Ticket) -> TicketTableViewController.TicketTableViewCell {
        guard let cell = view.dequeueReusableCell(
            withIdentifier: TicketTableViewController.TicketTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TicketTableViewController.TicketTableViewCell else { fatalError("Cell is not registered to view....") }
        cell.ticket = ticket
        return cell
    }
}

