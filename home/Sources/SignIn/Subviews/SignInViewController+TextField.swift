//
//  SignInViewController+TextField.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa

extension SignInViewController {
    final class TextField: BaseView {
        
        // MARK: - Property
        lazy var textFieldRx = textField.rx
        private let disposeBag = DisposeBag()
        
        var isSecure: Bool = false {
            didSet { update() }
        }
        
        var placeHolder: String? {
            didSet { update() }
        }
        
        // MARK: - View
        
        private var textFieldContainer: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
            view.layer.borderWidth = 1
            return view
        }()
        
        private lazy var textField: UITextField = {
            let textField = UITextField()
            textField.delegate = self
            textField.font = .sfProDisplay(size: 17)
            textField.textColor = .black
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            return textField
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(textFieldContainer)
            textFieldContainer.addSubview(textField)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.equalTo(textFieldContainer)
            }
            
            textFieldContainer.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(textField.snp.bottom).offset(18)
            }
            
            textField.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(18)
                make.leading.trailing.equalToSuperview().inset(18)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            textField.placeholder = placeHolder
            textField.isSecureTextEntry = isSecure
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.textField.becomeFirstResponder()
        }
    }
}

extension SignInViewController.TextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason) {
        textFieldContainer.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldContainer.layer.borderColor = UIColor(hexCode: "8303FF").cgColor
    }
}
