//
//  ChangePasswordViewController.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class ChangePasswordViewController: BaseViewController {
    
    enum PasswordStepState {
        case contactCheck
        case changePassword
    }
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private var status: PasswordStepState = .contactCheck
    
    private var contact: String? = nil
    private var validationCode: String? = nil
    
    private var password: String? = nil
    private var passwordCheck: String? = nil
    
    // MARK: - View
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sfProDisplay(size: 27)]
        
        let attributedText = NSMutableAttributedString(string: "비밀번호를 변경하기 위해\n휴대폰 인증을 진행해주세요.", attributes: baseAttributes)
        
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        // FIXME: - 한글 지원 폰트 필요
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 4))
        
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 14, length: 6))
        
        label.attributedText = attributedText
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        return button
    }()
    
    private var containerView: UIView = {
        UIView()
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        return stackView
    }()
    
    private var contactTextField: TextField = {
        let textField = TextField()
        textField.title = "전화번호"
        textField.placeHolder = "전화번호"
        textField.checkButton.isHidden = false
        return textField
    }()
    
    private var validationCodeTextField: TextField = {
        let textField = TextField()
        textField.title = "인증번호"
        textField.placeHolder = "인증번호"
        textField.incorrectText = "인증번호를 다시 확인해주세요."
        return textField
    }()
    
    private var passwordTextField: TextField = {
        let textField = TextField()
        textField.title = "비밀번호"
        textField.placeHolder = "비밀번호"
        textField.isHidden = true
        return textField
    }()
    
    private var passwordCheckTextField: TextField = {
        let textField = TextField()
        textField.title = "비밀번호 확인"
        textField.placeHolder = "비밀번호 확인"
        textField.incorrectText = "비밀번호가 일치하기 않아요."
        textField.isHidden = true
        return textField
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Point")
        button.setTitle("계속하기", for: .normal)
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
        
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(contactTextField)
        stackView.addArrangedSubview(validationCodeTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordCheckTextField)
    
        view.addSubview(containerView)
        view.addSubview(completeButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalTo(completeButton.snp.top).offset(-16)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(backButton.snp.bottom).offset(18)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(46)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualTo(completeButton.snp.top)
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
        backButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        contactTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.contact = text
            }
            .disposed(by: disposeBag)
        
        validationCodeTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.validationCode = text
            }
            .disposed(by: disposeBag)
        
        contactTextField.checkButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, text in
                owner.sendValidationCode()
            }
            .disposed(by: disposeBag)
        
        passwordTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.password = text
            }
            .disposed(by: disposeBag)
        
        passwordCheckTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.passwordCheck = text
            }
            .disposed(by: disposeBag)
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                switch owner.status {
                case .contactCheck: owner.checkValidationCode()
                case .changePassword: owner.changePassword()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func sendValidationCode(){
        // MARK: - Send Validation Code
    }
    
    func checkValidationCode(){
        guard !(contact?.isEmpty ?? true) else { return }
        guard !(validationCode?.isEmpty ?? true) else { return }
        
        // MARK: - Validation Code Check
        // FIXME: - TEMP Validation Code Check Logic
        let result = validationCode != "53246"
        
        if result {
            self.status = .changePassword
            updateToChangePasswordStepLayout()
        } else {
            validationCodeTextField.status = .incorrect
        }
    }
    
    func changePassword() {
        guard let password = password,
        let passwordCheck = passwordCheck else { return }
        
        let result = password == passwordCheck
        if result {
            passwordCheckTextField.status = .default
            // FIXME: - Change Password Logic
            
            self.navigationController?.popViewController(animated: true)
        } else {
            passwordCheckTextField.status = .incorrect
        }
    }
    
    func updateToChangePasswordStepLayout() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sfProDisplay(size: 27)]
        let attributedText = NSMutableAttributedString(string: "변경할 비밀번호를\n입력해주세요.", attributes: baseAttributes)
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        // FIXME: - 한글 지원 폰트 필요
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 8))
        titleLabel.attributedText = attributedText
        
        completeButton.backgroundColor = UIColor(named: "Primary color")
        completeButton.setTitle("완료", for: .normal)
        
        passwordTextField.isHidden = false
        passwordCheckTextField.isHidden = false
        contactTextField.isHidden = true
        validationCodeTextField.isHidden = true
    }
}
