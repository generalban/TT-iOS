//
//  TicketTableViewController+DropdownBox.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

extension TicketTableViewController {
    final class FilterDropDownView: BaseControl {
        // MARK: - Property
        
        var text: String = "" {
            didSet {
                update()
            }
        }
        
        var isOpenDropdown: Bool = false
        
        // MARK: - View
        
        private var containerView: UIView = {
            let view = UIImageView()
            view.layer.borderColor = UIColor(named: "Point")?.cgColor
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor(hexCode: "DFE4ED")
            view.layer.cornerRadius = 20
            return view
        }()
        
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 13)
            label.textColor = UIColor(hexCode: "33315B")
            label.textAlignment = .center
            return label
        }()
        
        private var downArrowIconView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "arrow_down")
            return imageView
        }()
        
        // MARK: - Init
        
        convenience init(text: String) {
            defer {
                self.text = text
            }
            
            self.init(frame: .zero)
        }
        
        // MARK: - UI
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(containerView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(downArrowIconView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            self.snp.makeConstraints { make in
                make.bottom.equalTo(containerView)
            }
            
            containerView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(titleLabel).offset(12)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(12)
                make.leading.equalToSuperview().inset(10)
                make.trailing.equalTo(downArrowIconView.snp.leading).inset(10)
            }
            
            downArrowIconView.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(15)
                make.size.equalTo(18)
                make.centerY.equalTo(titleLabel)
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            
            titleLabel.text = text
        }
    }
}
