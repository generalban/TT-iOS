//
//  EditUserInfoViewController+TextField.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

extension EditUserInfoViewController {
    enum TextFieldStatus {
        case incorrect
        case correct
        case `default`
    }
    
    final class TextField: BaseView {
        
        // MARK: - Property
        
        lazy var textFieldRx = textField.rx
        private let disposeBag = DisposeBag()
        
        var placeHolder: String? {
            didSet { update() }
        }
        
        var title: String? {
            didSet { update() }
        }
        
        var status: TextFieldStatus = .default {
            didSet { update() }
        }
        
        var hideCheckButton: Bool = false {
            didSet { update() }
        }
        
        var incorrectText: String? = nil
        var correctText: String? = nil
        
        // MARK: - View
        
        private var mainContainer: UIView = {
           UIView()
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .sfProDisplay(size: 14, weight: .semiBold)
            label.textColor = UIColor(hexCode: "33315B")
            return label
        }()
        
        private var textFieldContainer: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
            view.layer.borderWidth = 1
            return view
        }()
        
        private var textField: UITextField = {
            let textField = UITextField()
            textField.font = .sfProDisplay(size: 17)
            textField.textColor = .black
            return textField
        }()
        
        private var notificationLabel: UILabel = {
            let label = UILabel()
            label.text = "이미 있는 아이디에요."
            label.font = .sfProDisplay(size: 11)
            label.textColor = UIColor(hexCode: "FF002E")
            return label
        }()
        
        var checkButton: PaddedButton = {
            let button = PaddedButton()
            button.text = "중복 확인"
            button.textLabel.textColor = .white
            button.padding = .init(top: 11, left: 20, bottom: 11, right: 20)
            button.backgroundColor = UIColor(hexCode: "8303FF")
            button.isHidden = true
            return button
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(titleLabel)
            mainContainer.addSubview(textFieldContainer)
            textFieldContainer.addSubview(textField)
            
            mainContainer.addSubview(notificationLabel)
            textFieldContainer.addSubview(checkButton)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(textFieldContainer)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(6)
            }
            
            textFieldContainer.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(9)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(textField.snp.bottom).offset(18)
            }
            
            textField.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(18)
                make.leading.trailing.equalToSuperview().inset(18)
            }
            
            notificationLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(10)
                make.bottom.equalTo(textFieldContainer.snp.top).inset(-2)
            }
            
            checkButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(18)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            titleLabel.text = title
            textField.placeholder = placeHolder
            
            switch status {
            case .incorrect:
                notificationLabel.isHidden = false
                self.notificationLabel.text = self.incorrectText
                self.notificationLabel.textColor = UIColor(hexCode: "FF002E")
                self.textFieldContainer.layer.borderColor = UIColor(hexCode: "FF002E").cgColor
            case .correct:
                notificationLabel.isHidden = false
                self.notificationLabel.text = self.correctText
                self.notificationLabel.textColor = UIColor(hexCode: "8303FF")
                self.textFieldContainer.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
            case .default:
                notificationLabel.isHidden = true
                self.textFieldContainer.layer.borderColor = UIColor(hexCode: "B8BAC0").cgColor
            }
        }
    }
}
