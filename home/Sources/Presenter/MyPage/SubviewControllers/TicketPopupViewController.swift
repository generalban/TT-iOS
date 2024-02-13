//
//  TicketPopupViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

extension MyPageViewController {
    final class TicketPopupViewController: BaseViewController {
        
        var ticket: Ticket! {
            didSet {
                update()
            }
        }
        
        // MARK: - Property
        
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var backgroundView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: .dark)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            return visualEffectView
        }()
        
        private var mainContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
        
        private var ticketContentMask: TicketContentContainer = {
            TicketContentContainer()
        }()
        
        private var codeLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 12)
            label.textColor = UIColor(hexCode: "545454")
            return label
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 13, weight: .semiBold)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var statusContainerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "DFE4ED")
            view.layer.cornerRadius = 12
            return view
        }()
        
        private var statusLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        private var dividerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "F1F2F4")
            return view
        }()
        
        private var contentLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 11)
            label.textColor = UIColor(hexCode: "33315B")
            label.numberOfLines = 0
            return label
        }()
        
        private var deleteButton: PaddedButton = {
            PaddedButton(text: "삭제",
                         padding: .init(top: 6, left: 16, bottom: 6, right: 16),
                         textColor: UIColor(hexCode: "545454"),
                         backgroundColor: UIColor(hexCode: "FFDAE7"),
                         font: .sfProDisplay(size: 11),
                         cornerRadius: 12)
        }()
        
        private var tagStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 5
            return stackView
        }()
        
        private var tags: [TagView] = [TagView(iconText: "🔗", text: "참고 링크"),
                                       TagView(iconText: "😃", text: "마감이 완료된 티켓이에요!")]
        
        // MARK: - UI
        
        override func setUp() {
            super.setUp()
            
            view.backgroundColor = .clear
        }
        
        override func initView() {
            super.initView()
            
            view.addSubview(backgroundView)
            
            statusContainerView.addSubview(statusLabel)
            
            let tagStackViewSubviews: [UIView] = tags
            
            tagStackViewSubviews.forEach { subview in
                tagStackView.addArrangedSubview(subview)
            }
            
            let ticketContentContainerSubviews: [UIView] = [codeLabel,
                                                            titleLabel,
                                                            statusContainerView,
                                                            dividerView,
                                                            contentLabel,
                                                            tagStackView
            ]
            
            ticketContentContainerSubviews.forEach { subview in
                ticketContentMask.addSubview(subview)
            }
            
            mainContainerView.addSubview(ticketContentMask)
            mainContainerView.addSubview(deleteButton)
            
            view.addSubview(mainContainerView)
        }
        
        override func initConstraint() {
            super.initConstraint()
            
            backgroundView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }
            
            mainContainerView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.bottom.equalTo(ticketContentMask)
            }
            
            ticketContentMask.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(tagStackView).offset(10)
            }
            
            statusContainerView.snp.makeConstraints { make in
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(10)
                make.top.equalTo(10)
                make.width.equalTo(84)
                make.height.equalTo(24)
            }
            
            statusLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            }
            
            deleteButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(10)
                make.centerY.equalTo(statusLabel)
            }
            
            codeLabel.snp.makeConstraints { make in
                make.top.equalTo(statusContainerView.snp.bottom).offset(7)
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(10)
                make.trailing.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(codeLabel.snp.bottom).offset(4)
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(10)
                make.trailing.equalToSuperview().inset(10)
            }
            
            dividerView.snp.makeConstraints { make in
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(6)
                make.trailing.equalToSuperview().inset(6)
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.height.equalTo(1)
            }
            
            contentLabel.snp.makeConstraints { make in
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(10)
                make.trailing.equalToSuperview().inset(10)
                make.top.equalTo(dividerView.snp.bottom).offset(8)
            }
            
            tagStackView.snp.makeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(18)
                make.leading.equalTo(ticketContentMask.layoutGuideView).inset(6)
                make.trailing.equalToSuperview().inset(6)
            }
        }
        
        func update() {
            ticketContentMask.ticketColor = ticket.color
            codeLabel.text = ticket.code
            titleLabel.text = ticket.title
            statusLabel.text = ticket.status.rawValue
            contentLabel.text = ticket.content
        }
        
        // MARK: - Bind
        
        override func bind() {
            super.bind()
            deleteButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.complete()
                }
                .disposed(by: disposeBag)
        }
        
        private func complete() {
            dismiss(animated: false)
        }
    }
}


extension MyPageViewController.TicketPopupViewController {
    static func present(ticket: Ticket) {
        let viewController = MyPageViewController.TicketPopupViewController()
        viewController.ticket = ticket
        viewController.modalPresentationStyle = .overCurrentContext
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
}
