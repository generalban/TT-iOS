//
//  FeedbackPopupViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

final class FeedbackPopupViewController: BaseViewController {
    
    var alert: Alert! {
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
    
    private var ticketContentContainer: TicketContentContainer = {
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
    
    private var ticketInfoContainer: TicketInfoContainer = {
        TicketInfoContainer()
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
    
    private var deleteButton: PaddedButton = {
        PaddedButton(text: "삭제",
                     padding: .init(top: 6, left: 16, bottom: 6, right: 16),
                     textColor: UIColor(hexCode: "545454"),
                     backgroundColor: UIColor(hexCode: "FFDAE7"),
                     font: .sfProDisplay(size: 11),
                     cornerRadius: 12)
    }()
    
    private var ticketSubContentContainer = {
        TicketSubContentContainer()
    }()
    
    private var attachedFileTitleLable: PaddedButton = {
        PaddedButton(text: "첨부 파일",
                     padding: .init(top: 6, left: 20, bottom: 6, right: 20),
                     textColor: .white,
                     backgroundColor: .point)
    }()
    
    private var attachedFileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var linkTitleLable: PaddedButton = {
        PaddedButton(
            iconText:"🔗",
            text: "링크",
            padding: .init(top: 6, left: 20, bottom: 6, right: 20),
            textColor: UIColor(hexCode: "33315B"),
            backgroundColor: UIColor(hexCode: "DFE4ED"))
    }()
    
    private var linkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var subContentDividerView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F1F2F4")
        return view
    }()
    
    private var resendButton: PaddedButton = {
        PaddedButton(text: "다시 요청",
                     padding: .init(top: 6, left: 20, bottom: 6, right: 20))
    }()
    
    private var accpetButton: PaddedButton = {
        PaddedButton(text: "티켓 수락",
                     padding: .init(top: 6, left: 20, bottom: 6, right: 20),
                     textColor: .white,
                     backgroundColor: .point)
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .clear
    }
    
    override func initView() {
        super.initView()
        
        view.addSubview(backgroundView)
        
        statusContainerView.addSubview(statusLabel)
        
        let ticketContentContainerSubviews: [UIView] = [codeLabel,
                                                        titleLabel,
                                                        statusContainerView,
                                                        dividerView,
                                                        contentLabel
        ]
        
        ticketContentContainerSubviews.forEach { subview in
            ticketContentContainer.addSubview(subview)
        }
        
        let ticketInfoContainerSubviews: [UIView] = [dateLabel,
                                                     moveIcon]
        
        ticketInfoContainerSubviews.forEach { subview in
            ticketInfoContainer.addSubview(subview)
        }
        
        
        let ticketSubContentContainerSubviews: [UIView] = [attachedFileTitleLable,
                                                           attachedFileStackView,
                                                           linkTitleLable,
                                                           linkStackView,
                                                           subContentDividerView,
                                                           resendButton,
                                                           accpetButton]
        
        ticketSubContentContainerSubviews.forEach { subview in
            ticketSubContentContainer.addSubview(subview)
        }
        
        mainContainerView.addSubview(ticketSubContentContainer)
        mainContainerView.addSubview(ticketInfoContainer)
        mainContainerView.addSubview(ticketContentContainer)
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
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(ticketSubContentContainer)
        }
        
        ticketContentContainer.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(ticketInfoContainer.snp.leading)
            make.bottom.equalTo(contentLabel).offset(10)
        }
        
        statusContainerView.snp.makeConstraints { make in
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.top.equalTo(10)
            make.width.equalTo(84)
            make.height.equalTo(24)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(ticketContentContainer).inset(10)
            make.centerY.equalTo(statusLabel)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(statusContainerView.snp.bottom).offset(7)
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(codeLabel.snp.bottom).offset(4)
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(6)
            make.trailing.equalToSuperview().inset(6)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(dividerView.snp.bottom).offset(8)
        }
        
        ticketInfoContainer.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.bottom.equalTo(ticketContentContainer)
            make.width.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(2)
        }
        
        moveIcon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        ticketSubContentContainer.snp.makeConstraints { make in
            make.top.equalTo(ticketContentContainer.snp.bottom).inset(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(accpetButton).offset(12)
        }
        
        attachedFileTitleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(28)
        }
        
        attachedFileStackView.snp.makeConstraints { make in
            make.top.equalTo(attachedFileTitleLable.snp.bottom).offset(8)
            make.leading.equalTo(attachedFileTitleLable)
            make.trailing.equalToSuperview().inset(28)
        }
        
        linkTitleLable.snp.makeConstraints { make in
            make.top.equalTo(attachedFileStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(28)
        }
        
        linkStackView.snp.makeConstraints { make in
            make.top.equalTo(linkTitleLable.snp.bottom).offset(8)
            make.leading.equalTo(linkTitleLable)
            make.trailing.equalToSuperview().inset(28)
        }
        
        subContentDividerView.snp.makeConstraints { make in
            make.top.equalTo(linkStackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
        
        accpetButton.snp.makeConstraints { make in
            make.top.equalTo(subContentDividerView.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(8)
        }
        
        resendButton.snp.makeConstraints { make in
            make.top.equalTo(accpetButton)
            make.trailing.equalTo(accpetButton.snp.leading).offset(-3)
        }
    
    }
    
    func update() {
        guard let ticket = alert.ticket else { return }
        ticketContentContainer.ticketColor = ticket.color
        codeLabel.text = ticket.code
        titleLabel.text = ticket.title
        statusLabel.text = ticket.status.rawValue
        contentLabel.text = ticket.content
        dateLabel.text = ticket.date
        moveIcon.isHidden = !ticket.move
        alert.feedback?.files.forEach({ text in
            let button = PaddedButton(text: text, 
                                      padding: .init(top: 6, left: 12, bottom: 6, right: 12),
                                      textColor: UIColor(hexCode: "545454"),
                                      backgroundColor: UIColor(hexCode: "F8F9FC"),
                                      cornerRadius: 12)
            attachedFileStackView.addArrangedSubview(button)
        })
        alert.feedback?.links.forEach({ text in
            let button = PaddedButton(text: text,
                                      padding: .init(top: 6, left: 12, bottom: 6, right: 12),
                                      textColor: UIColor(hexCode: "545454"),
                                      backgroundColor: UIColor(hexCode: "F8F9FC"),
                                      cornerRadius: 12)
            linkStackView.addArrangedSubview(button)
        })
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
        
        resendButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                // FIXME: - Resend Request
                owner.complete()
            }
            .disposed(by: disposeBag)
        
        accpetButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.accept()
            }
            .disposed(by: disposeBag)
    }
    
    private func complete() {
        dismiss(animated: false)
    }
    
    func accept() {
        dismiss(animated: false)
        AlertPopup.present(text: "티켓 수락이 완료되었어요!")
    }
}


extension FeedbackPopupViewController {
    static func present(alert: Alert) {
        let viewController = FeedbackPopupViewController()
        viewController.alert = alert
        viewController.modalPresentationStyle = .overCurrentContext
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
}
