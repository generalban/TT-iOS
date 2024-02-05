//
//  RegisterViewController.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa

final class RegisterViewController: BaseViewController {
    
    enum RegisterStepState: Int {
        case name = 1
        case id = 2
        case password = 3
    }
    
    // MARK: - Property
    
    @UserDefaultsWrapper("user", defaultValue: nil)
    private var user: User?
    
    private let disposeBag = DisposeBag()
    private var status: RegisterStepState = .name
    
    private var name: String? = nil
    private var id: String? = nil
    private var password: String? = nil
    private var passwordCheck: String? = nil
    
    // MARK: - View
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = titleAttributeString(type: status)
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
    
    private lazy var progressBar: ProgressBar = {
        let progressBar = ProgressBar()
        progressBar.maxCount = 3
        progressBar.currentCount = status.rawValue
        return progressBar
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private var nameTextField: TextField = {
        let textField = TextField()
        textField.registerState = .name
        textField.placeHolder = "이름"
        return textField
    }()
    
    private var idTextField: TextField = {
        let textField = TextField()
        textField.registerState = .id
        textField.placeHolder = "아이디(10자 이내)"
        textField.incorrectText = "이미 있는 아이디에요."
        textField.correctText = "사용 가능한 아이디에요."
        textField.checkButton.text = "중복 확인"
        textField.checkButton.isHidden = false
        return textField
    }()
    
    private var passwordTextField: TextField = {
        let textField = TextField()
        textField.registerState = .password
        textField.placeHolder = "비밀번호"
        textField.isSecure = true
        textField.isHidden = true
        return textField
    }()
    
    private var passwordCheckTextField: TextField = {
        let textField = TextField()
        textField.registerState = .password
        textField.title = "비밀번호 확인"
        textField.placeHolder = "비밀번호 확인"
        textField.incorrectText = "비밀번호가 일치하기 않아요."
        textField.isSecure = true
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
    
    private lazy var textFields: [TextField] = [
        nameTextField,
        idTextField,
        passwordTextField,
        passwordCheckTextField
    ]
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
        updateLayout()
    }
    
    override func initView() {
        super.initView()
        
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(progressBar)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(idTextField)
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
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(70)
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
        
        nameTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.name = text
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
        
        passwordCheckTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.passwordCheck = text
            }
            .disposed(by: disposeBag)
        
        idTextField.checkButton
            .rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.idValidationCheck()
            }
            .disposed(by: disposeBag)
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.nextStep()
            }
            .disposed(by: disposeBag)
    }
    
    @discardableResult
    func idValidationCheck() -> Bool {
        // FIXME: - 아이디 중복확인 로직 필요
        // TEMP Id Validation CheckLogic
        let result = !(id?.isEmpty ?? true) && id != "11111"
        idTextField.status = result ? .correct : .incorrect
        return result
    }
    
    func passwordValidationCheck() -> Bool {
        let result = !(password?.isEmpty ?? true) && password == passwordCheck
        passwordCheckTextField.status = result ? .correct : .incorrect
        return result
    }
    
    func nextStep() {
        switch status {
        case .name: prepareNameNextStep()
        case .id: prepareIdNextStep()
        case .password: preparePasswordNextStep()
        }
        UIView.animate(withDuration: 0.4) { self.updateLayout() }
    }
    
    func prepareNameNextStep() {
        guard !(name?.isEmpty ?? true) else { return }
        status = .id
    }
    
    func prepareIdNextStep() {
        guard idValidationCheck() else { return }
        status = .password
    }
    
    func preparePasswordNextStep() {
        guard passwordValidationCheck() else { return }
        self.user = User(name: name ?? "", backgroundColor: .point)
        presentRegisterSuccessViewController()
    }
    
    func presentRegisterSuccessViewController() {
        let viewController = RegisterSuccessViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateLayout() {
        let status = status
        self.textFields.forEach { textField in
            textField.isHidden = !(textField.registerState == status)
        }
        self.progressBar.setCount(count: status.rawValue)
        self.titleLabel.attributedText = self.titleAttributeString(type: status)
        if status == .password {
            self.completeButton.setTitle("완료", for: .normal)
        }
        self.view.layoutIfNeeded()
        
    }
    
    func titleAttributeString(type: RegisterStepState) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sfProDisplay(size: 27)]
        
        switch type {
        case .name:
            let attributedText = NSMutableAttributedString(string: "Ticket-Tack에서 사용할\n이름을 입력해 주세요.", attributes: baseAttributes)
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 11))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 18, length: 2))
            return attributedText
        case .id:
            let attributedText = NSMutableAttributedString(string: "아이디를\n입력해 주세요.", attributes: baseAttributes)
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 3))
            return attributedText
        case .password:
            let attributedText = NSMutableAttributedString(string: "비밀번호를\n입력해 주세요.", attributes: baseAttributes)
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
            
            attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 4))
            return attributedText
        }
        
    }
}
