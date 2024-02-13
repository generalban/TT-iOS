//
//  TeamCalendarViewController+SelectionView.swift
//  home
//
//  Created by 오연서 on 2/8/24.
//

import UIKit
import SnapKit
import RxSwift
import RxRelay

extension TeamCalendarViewController {
    final class SelectionView: BaseView {
        
        // MARK: - Property
        
        var selectedTypeRelay: BehaviorRelay<Int>?
        let disposeBag = DisposeBag()
        
        // MARK: - Init
        
        convenience init(selectedTypeRelay: BehaviorRelay<Int>?) {
            defer {
                self.selectedTypeRelay = selectedTypeRelay
                self.bindRelay()
            }
            self.init()
        }
        
        // MARK: - View
        
        var typeStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 22
            return stackView
        }()
        
        lazy var typeSelectionButtons: [UIButton] = {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(top: 2, leading: 6, bottom: 2, trailing: 6)
            return ["To do", "In progress", "Done"].enumerated().map { idx, category in
                let button = UIButton(configuration: configuration)
                button.setTitle(category, for: .normal)
                button.setTitleColor(UIColor(hexCode: "33315B"), for: .normal)
                button.titleLabel?.font = .sfProDisplay(size: 14, weight: .semiBold)
                button.addTarget(self, action: #selector(selectType), for: .touchUpInside)
                button.tag = idx
                return button
            }
        }()
        
        var underline: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "8303FF")
            return view
        }()
        
        var divider: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "DEDEDE")
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            typeSelectionButtons.forEach { button in
                typeStackView.addArrangedSubview(button)
            }
            
            let mainSubviews: [UIView] = [typeStackView, underline, divider]
            
            mainSubviews.forEach { subview in
                self.addSubview(subview)
            }
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.bottom.equalTo(underline)
            }
            
            typeStackView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(22)
                make.top.equalToSuperview().inset(10)
                make.bottom.equalTo(divider.snp.top).offset(-12)
            }
            
            divider.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(1)
                make.bottom.equalTo(self.snp.bottom)
            }
            
            underline.snp.makeConstraints { make in
                make.bottom.equalTo(divider)
                make.height.equalTo(3)
                make.leading.trailing.equalTo(typeSelectionButtons[0])
            }
        }
        
        func bindRelay() {
            selectedTypeRelay?.subscribe { [weak self] category in
                guard let self = self else { return }
                let index = self.selectedTypeRelay?.value ?? 0
                UIView.animate(withDuration: 0.2) {
                    self.underline.snp.removeConstraints()
                    self.underline.snp.makeConstraints { make in
                        make.bottom.equalTo(self.divider)
                        make.height.equalTo(3)
                        make.leading.trailing.equalTo(self.typeSelectionButtons[index])
                    }
                    self.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        }
        
        @objc
        func selectType(sender: UIButton) {
            self.selectedTypeRelay?.accept(sender.tag)
        }
    }
}
