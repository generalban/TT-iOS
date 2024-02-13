//
//  AlertPopup.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

final class AlertPopup: BaseViewController {
    
    var icon: UIImage? = nil {
        didSet {
            iconView.image = icon
        }
    }
    
    var text: String = "" {
        didSet {
            alertLabel.text = text
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
    
    private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private var confirmButton: PaddedButton = {
        PaddedButton(text: "확인", padding: .init(top: 10, left: 60, bottom: 10, right: 60))
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .clear
    }
    
    override func initView() {
        super.initView()
        mainContainer.addSubview(iconView)
        mainContainer.addSubview(alertLabel)
        mainContainer.addSubview(confirmButton)
        
        view.addSubview(backgroundView)
        view.addSubview(mainContainer)
    }
    
    override func initConstraint() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(confirmButton).offset(16)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(52)
        }
        
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(alertLabel.snp.bottom).offset(26)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        confirmButton.rx
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

extension AlertPopup {
    static func present(icon: UIImage? = UIImage(named: "icon_check_fill"),
                        text: String) {
        let viewController = AlertPopup()
        viewController.icon = icon
        viewController.text = text
        viewController.modalPresentationStyle = .overCurrentContext
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
}
