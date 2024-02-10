//
//  ResendPopupViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ResendPopupViewController: BaseViewController {
    
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
    
    private var resendTitleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DFE4ED")
        view.layer.cornerRadius = 12
        return view
    }()
    
    private var resendTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 10, weight: .semiBold)
        label.text = "다시 요청 코멘트"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var resendContentLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 11)
        label.textColor = UIColor(hexCode: "33315B")
        label.numberOfLines = 0
        return label
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
        resendTitleContainerView.addSubview(resendTitleLabel)
        
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
        
        
        let ticketSubContentContainerSubviews: [UIView] = [resendTitleContainerView,
                                                           resendContentLabel]
        
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
            make.top.equalToSuperview().inset(10)
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
            make.bottom.equalTo(resendContentLabel).offset(10)
        }
        
        resendTitleContainerView.snp.makeConstraints { make in
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(120)
            make.height.equalTo(24)
        }
        
        resendTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        resendContentLabel.snp.makeConstraints { make in
            make.top.equalTo(resendTitleContainerView.snp.bottom).offset(13)
            make.leading.equalTo(ticketContentContainer.layoutGuideView).inset(10)
            make.trailing.equalToSuperview().inset(28)
        }
    }
    
    func update() {
        guard let ticket = alert.ticket else { return }
        ticketContentContainer.ticketColor = ticket.color
        codeLabel.text = ticket.code
        titleLabel.text = ticket.title
        statusLabel.text = ticket.status.rawValue
        contentLabel.text = ticket.content
        dateLabel.text = dateToString(ticket.dueDate)
        moveIcon.isHidden = !ticket.move
        if let resendComment = alert.resendComment {
            resendContentLabel.text = resendComment
        }
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


extension ResendPopupViewController {
    static func present(alert: Alert) {
        let viewController = ResendPopupViewController()
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
