//
//  PaddedButton.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

final class PaddedButton: BaseControl {
    
    
    var iconImage: UIImage? {  didSet { update() } }
    var iconText: String? {  didSet { update() } }
    var text: String? { didSet { update() } }
    var padding: UIEdgeInsets? = nil { didSet { update() } }
    
    // MARK: - View
    
    var container: UIView = {
        UIImageView()
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var iconLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    convenience init(icon: UIImage? = nil,
                     iconText: String? = nil,
                     text: String,
                     padding: UIEdgeInsets,
                     textColor: UIColor = .black,
                     backgroundColor:UIColor = UIColor(hexCode: "DFE4ED"),
                     font: UIFont = UIFont.sfProDisplay(size: 13),
                     cornerRadius: CGFloat = 10) {
        self.init()
        defer {
            self.iconImage = icon
            self.iconText = iconText
            self.text = text
            self.padding = padding
            self.textLabel.textColor = textColor
            self.textLabel.font = font
            self.iconLabel.textColor = textColor
            self.iconLabel.font = font
            self.backgroundColor = backgroundColor
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - UI
    
    override func prepare() {
        super.prepare()
        
        clipsToBounds = true
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(container)
        container.addSubview(stackView)
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(iconLabel)
        stackView.addArrangedSubview(textLabel)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(container)
        }
        
        container.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(stackView).offset(padding?.bottom ?? 0)
            make.trailing.equalTo(stackView).offset(padding?.right ?? 0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(padding?.top ?? 0)
            make.leading.equalToSuperview().inset(padding?.left ?? 0)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func update() {
        super.update()
        if iconImage != nil {  iconView.isHidden = false }
        if iconText != nil { iconLabel.isHidden = false }
        
        self.iconView.image = iconImage
        self.iconLabel.text = iconText
        self.textLabel.text = text

        container.snp.removeConstraints()
        stackView.snp.removeConstraints()
        container.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalTo(stackView).offset(padding?.bottom ?? 0)
            make.trailing.equalTo(stackView).offset(padding?.right ?? 0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(padding?.top ?? 0)
            make.leading.equalToSuperview().inset(padding?.left ?? 0)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
