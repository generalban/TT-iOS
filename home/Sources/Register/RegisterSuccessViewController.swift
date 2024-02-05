//
//  RegisterSuccessViewController.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa

final class RegisterSuccessViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View
    
    private var layoutView: UIView = {
        UIView()
    }()
    
    private var containerView: UIView = {
        UIView()
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_circle")
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입을 완료했어요!"
        label.textAlignment = .center
        label.font = .sfProDisplay(size: 27, weight: .semiBold)
        label.textColor = .black
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket-Taka 에서\n팀원들과 프로젝트를 시작해보세요."
        label.textAlignment = .center
        label.font = .sfProDisplay(size: 17)
        label.textColor = UIColor(hexCode: "545454")
        label.numberOfLines = 2
        return label
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "0CECEC")
        button.setTitle("홈 화면으로 가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        
        containerView.addSubview(logoImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        layoutView.addSubview(containerView)
        view.addSubview(layoutView)
        view.addSubview(completeButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        layoutView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(completeButton.snp.top)
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(descriptionLabel)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
