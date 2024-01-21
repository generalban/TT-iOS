//
//  PaddedButton.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

final class PaddedButton: BaseControl {
    
    var container: UIView = {
        UIImageView()
    }()
    
    var text: String? {
        didSet { update() }
    }
    
    var padding: UIEdgeInsets? = nil {
        didSet { update() }
    }
    
    // MARK: - View
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfProDisplay(size: 13)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    convenience init(text: String, padding: UIEdgeInsets) {
        self.init()
        defer {
            self.text = text
            self.padding = padding
        }
    }
    
    // MARK: - UI
    
    override func prepare() {
        super.prepare()
        
        self.backgroundColor = UIColor(hexCode: "DFE4ED")
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(container)
        container.addSubview(textLabel)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(container)
        }
        
        container.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(textLabel).offset(padding?.bottom ?? 0)
            make.trailing.equalTo(textLabel).offset(padding?.right ?? 0)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(padding?.top ?? 0)
            make.leading.equalToSuperview().inset(padding?.left ?? 0)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func update() {
        super.update()
        
        self.textLabel.text = text
        
        container.snp.removeConstraints()
        container.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(textLabel).offset(padding?.bottom ?? 0)
            make.trailing.equalTo(textLabel).offset(padding?.right ?? 0)
        }
        
        textLabel.snp.removeConstraints()
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(padding?.top ?? 0)
            make.leading.equalToSuperview().inset(padding?.left ?? 0)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
