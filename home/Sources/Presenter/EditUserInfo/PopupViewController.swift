//
//  PopupViewController.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class PopupViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var addedTeamIconImage: UIImage? = nil
    
    
    // MARK: - View
    
    private var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "warning"))
        return imageView
    }()
    
    private var descriptionContainer: UIView = {
        UIView()
    }()
    
    private var confirmButton: PaddedButton = {
        let button = PaddedButton()
        button.text = "확인"
        button.padding = .init(top: 10, left: 60, bottom: 10, right: 60)
        return button
    }()
    
    private var descriptoinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "이미 가입된 이메일이에요!"
        label.font = .sfProDisplay(size: 16)
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
        view.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(descriptionContainer)
        containerView.addSubview(confirmButton)
        descriptionContainer.addSubview(descriptoinLabel)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(200)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(28)
            make.width.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
        descriptionContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(iconImageView.snp.bottom)
            make.bottom.equalTo(confirmButton.snp.top)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(28)
        }
        
        descriptoinLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        confirmButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.dismissScreen()
            }
            .disposed(by: disposeBag)
    }
    
    private func dismissScreen() {
        dismiss(animated: false)
    }
}
