//
//  FeedbackRequestPopupViewController+FileDropDownMenuView.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

extension FeedbackRequestPopupViewController {
    enum FileDropDownMenuType: String {
        case gallery
        case selectFile
        case cancel
    }
    
    final class FileDropDownMenuView: BaseView {
        
        // MARK: - Property
        
        var delegate: FileDropDownMenuViewDelegate?

        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var mainContainer: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.backgroundColor = .white
            stackView.layer.cornerRadius = 10
            stackView.clipsToBounds = true
            return stackView
        }()
        
        private var galleryButton: PaddedButton = {
            PaddedButton(text: "사진 앨범",
                         padding: .init(top: 10, left: 0, bottom: 10, right: 0),
                         textColor: UIColor(hexCode: "545454"),
                         backgroundColor: .clear)
        }()
        
        private var fileSelectButton: PaddedButton = {
            PaddedButton(text: "파일 선택",
                         padding: .init(top: 10, left: 0, bottom: 10, right: 0),
                         textColor: UIColor(hexCode: "545454"),
                         backgroundColor: .clear)
        }()
        
        private var cancelButton: PaddedButton = {
            PaddedButton(text: "취소",
                         padding: .init(top: 10, left: 0, bottom: 10, right: 0),
                         textColor: UIColor(hexCode: "FF3B30"),
                         backgroundColor: .clear)
        }()
        
        private var divider1: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor(hexCode: "111111", alpha: 0.25)
            return view
        }()
        
        private var divider2: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor(hexCode: "111111", alpha: 0.25)
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
            layer.cornerRadius = 10
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowColor = UIColor(hexCode: "000000", alpha: 0.25).cgColor
            layer.shadowRadius = 5
            layer.shadowOpacity = 1
            layer.masksToBounds = false
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            [galleryButton,
             divider1,
             fileSelectButton,
             divider2,
             cancelButton].forEach { subview in
                mainContainer.addArrangedSubview(subview)
            }
            
            addSubview(mainContainer)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.width.equalTo(170)
                make.height.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }
            
            [divider1, divider2].forEach { divider in
                divider.snp.makeConstraints { make in
                    make.height.equalTo(1)
                }
            }
        }
        
        // MARK: - Bind
        
        override func bindEvents() {
            galleryButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.selectButton(type: .gallery)
                }
                .disposed(by: disposeBag)
            
            fileSelectButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.selectButton(type: .selectFile)
                }
                .disposed(by: disposeBag)
            
            cancelButton.rx
                .controlEvent(.touchUpInside)
                .bind(with: self) { owner, _ in
                    owner.delegate?.selectButton(type: .cancel)
                }
                .disposed(by: disposeBag)
        }
    }
}

protocol FileDropDownMenuViewDelegate {
    func selectButton(type: FeedbackRequestPopupViewController.FileDropDownMenuType)
}
