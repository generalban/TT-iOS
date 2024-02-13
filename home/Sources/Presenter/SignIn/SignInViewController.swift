//
//  SignInViewController.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SignInViewController: BaseViewController {
    
    // MARK: - Property
    
    @UserDefaultsWrapper("user", defaultValue: nil)
    private var user: User?
    
    private let disposeBag = DisposeBag()
    
    private var id: String? = nil
    private var password: String? = nil
    
    // MARK: - View
    
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        return button
    }()
    
    private var layoutView: UIView = {
        UIView()
    }()
    
    private var containerView: UIView = {
        UIView()
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_logo")
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private var idTextField: TextField = {
        let textField = TextField()
        textField.placeHolder = "아이디"
        return textField
    }()
    
    private var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeHolder = "비밀번호"
        textField.isSecure = true
        return textField
    }()
    
    private var maintainButton: MaintainButton = {
        MaintainButton()
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "0CECEC")
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private var findStackView: UIStackView = {
      let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private var findIdButton: UnderlineButton = {
       let button = UnderlineButton()
        button.text = "아이디 찾기"
        return button
    }()
    
    private var findPasswordButton: UnderlineButton = {
       let button = UnderlineButton()
        button.text = "비밀번호 찾기"
        return button
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
        // hideKeyboard()
    }
    
    override func initView() {
        super.initView()
        
        containerView.addSubview(logoImageView)
        containerView.addSubview(stackView)
        containerView.addSubview(maintainButton)
        containerView.addSubview(signInButton)
        containerView.addSubview(findStackView)
        
        stackView.addArrangedSubview(idTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        findStackView.addArrangedSubview(findIdButton)
        findStackView.addArrangedSubview(findPasswordButton)

        layoutView.addSubview(containerView)
        view.addSubview(layoutView)
        view.addSubview(backButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).inset(20)
        }
        
        layoutView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.bottom.equalTo(findStackView)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(84)
            make.height.equalTo(75)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview()
        }
        
        maintainButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(maintainButton.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        
        findStackView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        backButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        idTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.id = text
            }
            .disposed(by: disposeBag)
        
        passwordTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.password = text
            }
            .disposed(by: disposeBag)
        
        signInButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.signIn()
            }
            .disposed(by: disposeBag)
    }
    
    func signIn() {
        guard !(id?.isEmpty ?? true) else { return }
        
        // FIXME: - 로그인 확인 로직 필요
        // TEMP SignIn Validation CheckLogic
        self.user = User(name: id ?? "",
                         backgroundColor: .point)
        self.navigationController?.popViewController(animated: true)
    }
}
