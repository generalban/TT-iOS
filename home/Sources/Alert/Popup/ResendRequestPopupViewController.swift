//
//  ResendRequestPopupViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

final class ResendRequestPopupViewController: BaseViewController {
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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 13, weight: .semiBold)
        label.textAlignment = .left
        label.text = "다시 요청할 코멘트"
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DEDEDE")
        return view
    }()
    
    private var placeholder: UITextView = {
        let textView = UITextView()
        textView.font = .sfProDisplay(size: 12)
        textView.textAlignment = .left
        textView.text = "다시 요청할 코멘트 작성"
        textView.textColor = UIColor(hexCode: "B8BAC0")
        return textView
    }()
    
    private lazy var textField: UITextView = {
        let textView = UITextView()
        textView.font = .sfProDisplay(size: 12)
        textView.textAlignment = .left
        textView.isEditable = true
        textView.delegate = self
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        return textView
    }()
    
    private var sendButton: PaddedButton = {
        PaddedButton(text: "보내기",
                     padding: .init(top: 6, left: 26, bottom: 6, right: 26),
                     textColor: .white,
                     backgroundColor: UIColor(hexCode: "8303FF"))
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .clear
    }
    
    override func initView() {
        super.initView()
        
        mainContainer.addSubview(titleLabel)
        mainContainer.addSubview(dividerView)
        mainContainer.addSubview(placeholder)
        
        mainContainer.addSubview(sendButton)
        mainContainer.addSubview(textField)
        
        view.addSubview(backgroundView)
        view.addSubview(mainContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func initConstraint() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(sendButton).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        
        placeholder.snp.makeConstraints { make in
            make.top.leading.equalTo(textField)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textField.snp.bottom).offset(4)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        sendButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.complete()
            }
            .disposed(by: disposeBag)
    }
    
    private func complete() {
        dismiss(animated: false)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               let keyboardHeight = keyboardSize.height
               
               mainContainer.snp.updateConstraints { make in
                   make.centerY.equalToSuperview().offset(-keyboardHeight/2)
               }

               UIView.animate(withDuration: 0.3) {
                   self.view.layoutIfNeeded()
               }
           }
       }

       @objc func keyboardWillHide(_ notification: Notification) {
           mainContainer.snp.updateConstraints { make in
               make.centerY.equalToSuperview()
           }

           UIView.animate(withDuration: 0.3) {
               self.view.layoutIfNeeded()
           }
       }
}

extension ResendRequestPopupViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
}

extension ResendRequestPopupViewController {
    static func present(alert: Alert) {
        let viewController = ResendRequestPopupViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
}
