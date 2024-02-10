//
//  TeamCalendarViewController+TopView.swift
//  home
//
//  Created by 오연서 on 2/7/24.
//

import UIKit

extension TeamCalendarViewController {
    final class TopView: BaseView {
        
        // MARK: - View
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Ticket-Taka 팀의 캘린더"
            label.numberOfLines = 0
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
            return label
        }()
        
        private var dividerView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(hexCode: "F6F6F6")
            return view
        }()
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            backgroundColor = UIColor(named:"메뉴 배경 1")
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(titleLabel)
            addSubview(dividerView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(30)
            }
            
            dividerView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(10)
            }
            
            
        }
    }
}

