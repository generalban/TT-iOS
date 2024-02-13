//
//  MyCalendarViewController+CalenderTopView.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit

extension MyCalendarViewController {
    final class CalendarTopView: BaseView {
        
        
        // MARK: - Property
        
        let didTapbackButtonCompletionHandler: (() -> Void)
        let didTapforwardButtonCompletionHandler: (() -> Void)
        
        // MARK: - View
        
        private lazy var topView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 25
            view.backgroundColor = UIColor(named: "활성화 테두리")
            return view
        }()
        
        lazy var backButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "icon_left")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.tintColor = UIColor(named: "활성화 테두리")
            button.addTarget(self, action: #selector(didTapbackButton), for: .touchUpInside)
            return button
        }()
        
        lazy var forwardButton: UIButton = {
            let button = UIButton()
            let image = UIImage(named: "icon_right")?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.tintColor = UIColor(named: "활성화 테두리")
            button.addTarget(self, action: #selector(didTapforwardButton), for: .touchUpInside)

            return button
        }()
        
        lazy var monthLabel: UILabel = {
            let view = UILabel()
            view.text = dateFormatter.string(from: baseDate)
            view.textColor = .white
            view.textAlignment = .center
            view.font = UIFont(name: "Inter-Medium", size: 17)
            return view
        }()
        
        var baseDate = Date() {
            didSet {
                monthLabel.text = dateFormatter.string(from: baseDate)
            }
        }
        
        private lazy var dateFormatter: DateFormatter = {
          let dateFormatter = DateFormatter()
          dateFormatter.calendar = Calendar(identifier: .gregorian)
          dateFormatter.locale = Locale.autoupdatingCurrent
          dateFormatter.setLocalizedDateFormatFromTemplate("y MMMM")
          return dateFormatter
        }()
        
        lazy var dayLabel: UILabel = {
            let view = UILabel()
            view.text = "SUN    MON    TUE    WED    THU    FRI    SAT"
            view.textColor = UIColor(named: "서브 텍스트 1")
            view.font = UIFont(name: "Inter-Medium", size: 15)
            view.textAlignment = .center
            return view
        }()
        
        init(
            didTapbackButtonCompletionHandler: @escaping (() -> Void),
            didTapforwardButtonCompletionHandler: @escaping (() -> Void)
        ) {
          self.didTapbackButtonCompletionHandler = didTapbackButtonCompletionHandler
          self.didTapforwardButtonCompletionHandler = didTapforwardButtonCompletionHandler

          super.init(frame: CGRect.zero)
          translatesAutoresizingMaskIntoConstraints = false
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            addSubview(topView)
            [backButton, monthLabel, forwardButton].forEach {view in topView.addSubview(view)}
            addSubview(dayLabel)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            topView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(50)
            }
            
            backButton.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.leading.equalToSuperview().inset(10)
                make.centerY.equalToSuperview()
            }
            
            forwardButton.snp.makeConstraints { make in
                make.height.width.equalTo(30)
                make.trailing.equalToSuperview().inset(10)
                make.centerY.equalToSuperview()
            }
            
            monthLabel.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            
            dayLabel.snp.makeConstraints { make in
                make.leading.trailing.equalTo(topView)
                make.top.equalTo(topView.snp.bottom).offset(10)
            }
        }
        
        @objc func didTapbackButton() {
          didTapbackButtonCompletionHandler()
        }

        @objc func didTapforwardButton() {
          didTapforwardButtonCompletionHandler()
        }
    }
}
