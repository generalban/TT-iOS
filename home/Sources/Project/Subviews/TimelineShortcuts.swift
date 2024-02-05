//
//  TimelineShortcuts.swift
//  home
//
//  Created by 오연서 on 2/1/24.
//
import UIKit
import RxSwift
import RxCocoa

extension ProjectViewController {
    final class TimelineShortcuts: BaseView {
        
        
        // MARK: - Property
        
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "Cool gray 4")
            view.layer.cornerRadius = 10
            return view
        }()
        
        private lazy var timelineLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "타임라인 바로가기"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)

            return label
        }()
        
        private(set) lazy var shortcutsIconButton: UIButton = {
            let view = UIButton()
            view.setImage(UIImage(named: "icon_shortcuts"), for: .normal)
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            backgroundColor = .white
            containerView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(containerView)
            [timelineLabel, shortcutsIconButton].forEach { view in containerView.addSubview(view)}
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            containerView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.centerX.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(30)
                make.height.equalTo(60)
            }
            
            timelineLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(15)
                make.centerY.equalToSuperview()
            }
            
            shortcutsIconButton.snp.makeConstraints { make in
                make.size.equalTo(30)
                make.trailing.equalTo(containerView.snp.trailing).inset(10)
                make.centerY.equalToSuperview()
            }            
        }
    }
}
