//
//  AlertTableViewCell.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

extension AlertViewController {
    enum AlertTableViewCellActionType {
        case accept
        case refuse
        case present
    }
    class AlertTableViewCell: BaseTableViewCell {
        
        var delegate: AlertTableViewCellDelegate?
        
        var alert: Alert! {
            didSet {
                update()
            }
        }
        
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "F8F9FC")
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            return view
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var dateLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "9897B1")
            return label
        }()
        
        private var iconView: UIImageView = {
           let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private var descriptionLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(hexCode: "33315B")
            label.lineBreakMode = .byTruncatingTail
            label.font = .sfProDisplay(size: 12, weight: .semiBold)
            return label
        }()
        
        private var buttonStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 5
            return stackView
        }()
        
        private var acceptButton: PaddedButton = {
            let button = PaddedButton(text: "수락",
                         padding: .init(top: 10, left: 20, bottom: 10, right: 20),
                         textColor: .white,
                         backgroundColor: .point)
            button.isHidden = true
            return button
        }()
        
        private var refuseButton: PaddedButton = {
            let button = PaddedButton(text: "거절",
                         padding: .init(top: 10, left: 20, bottom: 10, right: 20))
            button.isHidden = true
            return button
        }()
        
        private var presentButton: PaddedButton = {
            let button = PaddedButton(text: "보기",
                         padding: .init(top: 10, left: 20, bottom: 10, right: 20),
                         textColor: .white,
                         backgroundColor: .point)
            button.isHidden = true
            return button
        }()

        
        // MARK: - UI
        
        override func configureSubviews() {
            backgroundColor = .clear
            super.configureSubviews()
            
            [titleLabel,
             dateLabel, 
             iconView,
             descriptionLabel,
             buttonStackView
            ].forEach { subview in
                containerView.addSubview(subview)
            }
            
            [refuseButton,
             acceptButton,
             presentButton].forEach { subview in
                buttonStackView.addArrangedSubview(subview)
            }
            
            contentView.addSubview(containerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            containerView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(90)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.leading.equalToSuperview().inset(15)
                make.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(4)
            }
            
            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel)
                make.trailing.equalToSuperview().inset(15)
            }
            
            iconView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(16)
                make.leading.equalToSuperview().inset(18)
                make.size.equalTo(24)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.leading.equalTo(iconView.snp.trailing).offset(20)
                make.trailing.lessThanOrEqualTo(buttonStackView.snp.leading).offset(-4)
                make.centerY.equalTo(iconView)
            }
            
            buttonStackView.snp.makeConstraints { make in
                make.centerY.equalTo(iconView)
                make.trailing.equalToSuperview().inset(15)
            }
        }
        
        override func update() {
            super.update()
            
            switch alert.type {
            case .feedback:
                titleLabel.text = "\(alert.sender) 님이 티켓 피드백 요청을 보냈어요!"
                iconView.image = UIImage(named: "icon_send")
                descriptionLabel.text = alert.team
                presentButton.isHidden = false
            case .invite:
                titleLabel.text = "새로운 팀 초대가 도착했어요!"
                iconView.image = UIImage(named: "icon_team_gray")
                descriptionLabel.text = alert.team
                refuseButton.isHidden = false
                acceptButton.isHidden = false
            case .sendTicket:
                titleLabel.text = "\(alert.sender) 님이 티켓을 보냈어요!"
                iconView.image = UIImage(named: "icon_ticket")
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 6
                let baseAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.sfProDisplay(size: 12)]
                let attributedText = NSMutableAttributedString(string: "\(alert.team) 팀에서 확인해보세요",
                                                               attributes: baseAttributes)
                attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
                attributedText.addAttribute(.font,
                                            value: UIFont.sfProDisplay(size: 12, weight: .semiBold),
                                            range: NSRange(location: 0, length: alert.team.count))
                descriptionLabel.attributedText = attributedText
                presentButton.isHidden = false
            case .resend:
                titleLabel.text = "\(alert.sender) 님이 티켓을 다시 요청했어요!"
                iconView.image = UIImage(named: "icon_resend")
                descriptionLabel.text = alert.team
                presentButton.isHidden = false
            }
            
            dateLabel.text = alert.ago
        }
        
        func selected() {
            
        }
        
        override func bindEvents() {
            acceptButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.alertTableViewCell(type: .accept, alert: owner.alert)
                }
                .disposed(by: disposeBag)
            
            refuseButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.alertTableViewCell(type: .refuse, alert: owner.alert)
                }
                .disposed(by: disposeBag)
            
            presentButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.alertTableViewCell(type: .present, alert: owner.alert)
                }
                .disposed(by: disposeBag)
        }
    }
}

extension AlertViewController.AlertTableViewCell {
    static func makeCell(to view: UITableView,
                         indexPath: IndexPath,
                         alert: Alert,
                         delegate: AlertTableViewCellDelegate) -> AlertViewController.AlertTableViewCell {
        guard let cell = view.dequeueReusableCell(
            withIdentifier: AlertViewController.AlertTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlertViewController.AlertTableViewCell else { fatalError("Cell is not registered to view....") }
        cell.delegate = delegate
        cell.alert = alert
        return cell
    }
}

protocol AlertTableViewCellDelegate {
    func alertTableViewCell(type: AlertViewController.AlertTableViewCellActionType,
                            alert: Alert)
}

