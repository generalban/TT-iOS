//
//  EditMyInfoViewController.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class EditUserInfoViewController: BaseViewController {
    
    // MARK: - Property
    
    private var name: String? = nil
    private var id: String? = nil
    private var email: String? = nil
    
    private let disposeBag = DisposeBag()
    private var addedTeamIconImage: UIImage? = nil
    
    // MARK: - View
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    private var containerView: UIView = {
        UIView()
    }()
    
    private var editProfileButton: ProfileImageButton = {
        ProfileImageButton()
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        return stackView
    }()
    
    private var nameTextField: TextField = {
        let textField = TextField()
        textField.title = "이름"
        textField.placeHolder = "이름"
        return textField
    }()
    
    private var idTextField: TextField = {
        let textField = TextField()
        textField.title = "아이디"
        textField.placeHolder = "아이디"
        textField.correctText = "사용 가능한 아이디에요."
        textField.incorrectText = "이미 있는 아이디에요."
        textField.checkButton.isHidden = false
        return textField
    }()
    
    private var emailTextField: TextField = {
        let textField = TextField()
        textField.title = "이메일"
        textField.placeHolder = "이메일"
        return textField
    }()
    
    private var connectedSNSView: ConnectedSNSView = {
        let snsView = ConnectedSNSView()
        snsView.title = "연동된 SNS"
        return snsView
    }()
    
    private var changePasswordButton: ChangePasswordButton = {
        let changePasswordButton = ChangePasswordButton()
        changePasswordButton.contentText = "비밀번호 변경하기"
        return changePasswordButton
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Primary color")
        button.setTitle("완료", for: .normal)
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
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(backButton)
        containerView.addSubview(editProfileButton)
        containerView.addSubview(stackView)
        view.addSubview(completeButton)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(idTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(connectedSNSView)
        stackView.addArrangedSubview(changePasswordButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top).offset(-16)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(self.view).inset(20)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(editProfileButton.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(containerView)
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
        
        emailTextField.textFieldRx
            .text
            .bind(with: self) { owner, text in
                owner.email = text
            }
            .disposed(by: disposeBag)
        
        editProfileButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.showChangeProfileImageActionSheet()
            }
            .disposed(by: disposeBag)
        
        idTextField.checkButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.isValidId()
            }
            .disposed(by: disposeBag)
        
        changePasswordButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.presentChangePasswordViewController()
            }
            .disposed(by: disposeBag)
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.complete()
            }
            .disposed(by: disposeBag)
    }
}

extension EditUserInfoViewController {
    
    func isValidId() {
        // MARK: - Id Check
        // FIXME: - TEMP Valid Check Logic
        guard !(id?.isEmpty ?? true) else { return }
        let result: TextFieldStatus = id == "11111" ? .incorrect : .correct
        
        idTextField.status = result
    }
    
    func complete() {
        // MARK: - Complete Button Tapped
        // FIXME: - Temp Complete Logic
        let result = false
        if result {
      
        } else {
            let viewController = PopupViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            let rootVC = UIApplication
                .shared
                .connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .last?.rootViewController as? UINavigationController
            rootVC?.present(viewController, animated: false)
        }
    }
    
    func showChangeProfileImageActionSheet() {
        let actionSheetController = UIAlertController()
        let actionDefault = UIAlertAction(title: "기본 이미지로 변경",
                                         style: .default,
                                         handler: changeDefault)
        let actionCamera = UIAlertAction(title: "카메라",
                                         style: .default,
                                         handler: openCameraAction)
        let actionGallery = UIAlertAction(title: "사진 앨범",
                                          style: .default,
                                          handler: openGalleryAction)
        let actionCancel = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheetController.addAction(actionDefault)
        actionSheetController.addAction(actionCamera)
        actionSheetController.addAction(actionGallery)
        actionSheetController.addAction(actionCancel)
        
        self.present(actionSheetController, animated: true)
    }
    
    func changeDefault(_ action: UIAlertAction) { }
    func openCameraAction(_ action: UIAlertAction) { }
    func openGalleryAction(_ action: UIAlertAction) { }
}

extension EditUserInfoViewController {
    private func presentChangePasswordViewController() {
        let viewController = ChangePasswordViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
