//
//  FeedbackRequestPopupViewController+AttachLinkView.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

import RxSwift
import RxCocoa

extension FeedbackRequestPopupViewController {
    final class AttachLinkView: BaseView {
        
        // MARK: - Property
        
        var text: String?
        
        var delegate: AttachLinkViewDelegate?
        
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var mainContainer: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
            return view
        }()
        
        private var textFieldContainer: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "F8F9FC")
            view.layer.cornerRadius = 5
            return view
        }()
        
        private var textField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "첨부할 링크를 입력해주세요."
            textField.font = .sfProDisplay(size: 10)
            textField.textColor = UIColor(hexCode: "33315B")
            return textField
        }()
        
        private var attachButton: PaddedButton = {
            PaddedButton(text: "첨부",
                         padding: .init(top: 8, left: 10, bottom: 8, right: 10),
                         textColor: UIColor(hexCode: "33315B"),
                         backgroundColor: UIColor(hexCode: "DFE4ED"),
                         cornerRadius: 5)
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            self.backgroundColor = .white
            layer.cornerRadius = 10
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowColor = UIColor(hexCode: "000000", alpha: 0.25).cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            textFieldContainer.addSubview(textField)
            mainContainer.addSubview(textFieldContainer)
            mainContainer.addSubview(attachButton)
            addSubview(mainContainer)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                    
                make.width.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.trailing.bottom.equalTo(attachButton).offset(4)
            }
            
            textFieldContainer.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().inset(4)
                make.width.equalTo(220)
                make.height.equalTo(attachButton)
            }
            
            textField.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(6)
                make.top.bottom.equalToSuperview()
            }
            
            attachButton.snp.makeConstraints { make in
                make.leading.equalTo(textField.snp.trailing).offset(4)
                make.top.equalTo(textField)
            }
        }
        
        // MARK: - Bind
        
        override func bindEvents() {
            textField.rx.text
                .bind(with: self) { owner, text in
                    owner.text = text
                }
                .disposed(by: disposeBag)
            
            attachButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.attachLink(link: owner.text ?? "")
                    owner.textField.text = ""
                }
                .disposed(by: disposeBag)
        }
    }
}

protocol AttachLinkViewDelegate {
    func attachLink(link: String)
}
