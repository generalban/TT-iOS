//
//  CreateTIcketViewController+PeriodView.swift
//  home
//
//  Created by 오연서 on 2/14/24.
//

import UIKit

extension CreateTicketViewController {
    final class PeriodView: BaseView {
        
        // MARK: - View
        
        private lazy var startLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "시작 날짜"
            return label
        }()
        
        private lazy var startDate: UIDatePicker = {
            let view = UIDatePicker()
            view.preferredDatePickerStyle = .compact
            view.datePickerMode = .date
            view.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
            return view
        }()
        
        private lazy var endLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = "마감 날짜"
            return label
        }()
        
        private lazy var endDate: UIDatePicker = {
            let view = UIDatePicker()
            view.preferredDatePickerStyle = .compact
            view.datePickerMode = .date
            view.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)

            return view
        }()
        
        @objc
        private func handleDatePicker(_ sender: UIDatePicker) {
        }
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            [startLabel, startDate, endLabel, endDate].forEach { view in
                addSubview(view)
            }
            
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            startLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
            }
            
            startDate.snp.makeConstraints { make in
                make.centerY.equalTo(startLabel.snp.centerY)
                make.leading.equalTo(startLabel.snp.trailing).offset(10)
            }
            
            endLabel.snp.makeConstraints { make in
                make.top.equalTo(startLabel.snp.bottom).offset(30)
                make.leading.equalToSuperview()
            }
            
            endDate.snp.makeConstraints { make in
                make.centerY.equalTo(endLabel.snp.centerY)
                make.leading.equalTo(endLabel.snp.trailing).offset(10)
            }
        }
    }
}
